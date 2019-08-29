$ErrorActionPreference="Stop"

if($env:DEV_ENVIRONMENT -eq 1)
{
    Write-Host "Running in Dev environment"
    Start-Process "c:/servicemonitor.exe" -ArgumentList "w3svc","sc"
    
    Write-Host ("{0}: Invoking local Sitecore instance..." -f [DateTime]::Now.ToString("HH:mm:ss:fff"))
    Invoke-WebRequest http://localhost -UseBasicParsing | Out-Null
    Write-Host ("{0}: Sitecore instance is running" -f [DateTime]::Now.ToString("HH:mm:ss:fff"))

    Invoke-Expression -Command "c:/Sitecore/Scripts/Start-VSRemoteDebug.ps1" 
    Invoke-Expression -Command "c:/Sitecore/Scripts/Watch-Directory.ps1 -Path 'c:/src' -Destination 'c:/inetpub/sc'"

}
else{
    Write-Host "Running in non-Dev environment"

    if(Test-Path "c:/src"){
        Write-Host "Copy deployment files to c:/inetpub/sc"
        Robocopy c:/src c:/inetpub/sc /e /xo
    }

    Write-Host "Starting W3SVC service"
    Start-Service w3svc

    Write-Host ("{0}: Invoking local Sitecore instance..." -f [DateTime]::Now.ToString("HH:mm:ss:fff"))
    Invoke-WebRequest http://localhost -UseBasicParsing | Out-Null
    Write-Host ("{0}: Sitecore instance is running" -f [DateTime]::Now.ToString("HH:mm:ss:fff"))

    # Get the latest Sitecore log file location
    $pastDate = Get-Date
    $pastDate = $pastDate.AddDays(-365)
    $latestLogFilePath = ""
    $totalLogFiles = (Get-ChildItem -Path C:\inetpub\sc\App_Data\logs -Include log.*.txt | Measure-Object).Count
    Write-Host "Total log files $totalLogFiles" 
    Get-ChildItem -Path C:\inetpub\sc\App_Data\logs -Include log* |  Foreach-Object {
        if($_.LastWriteTime -gt $pastDate){
            Write-Host $_.FullName
            $pastDate = $_.LastWriteTime;
            $latestLogFilePath = $_.FullName;
        }
    }
    Write-Host "Found the latest log file at $latestLogFilePath"

    # Use spinner to read the log file
    Write-Host "Monitor the site"
    & c:/spinner/spinner.exe site http://localhost -t $latestLogFilePath
}