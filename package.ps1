$ErrorActionPreference = "Stop"

$nugetFolderPath = ".\devops\tools\nuget"
if(-not(Test-Path $nugetFolderPath)){
    New-Item -Type Directory -Path $nugetFolderPath
    Invoke-WebRequest "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -UseBasicParsing -OutFile "$nugetFolderPath\nuget.exe"
}


Copy-Item -Path .\devops\helmcharts\ -Destination .\artifacts\ -Recurse -Force