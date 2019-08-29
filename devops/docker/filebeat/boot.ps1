# Delete and stop the service if it already exists.
if (Get-Service filebeat -ErrorAction SilentlyContinue) {
    $service = Get-WmiObject -Class Win32_Service -Filter "name='filebeat'"
    $service.StopService()
    Start-Sleep -s 1
    $service.delete()
}

$workdir = Split-Path $MyInvocation.MyCommand.Path

# Create the new service.
New-Service -name filebeat `
    -displayName Filebeat `
    -binaryPathName "`"$workdir\filebeat.exe`" -c `"$workdir\filebeat.yml`" -path.home `"$workdir`" -path.data `"C:\data`" -path.logs `"C:\logs`""

# Start service
$service = Get-WmiObject -Class Win32_Service -Filter "name='filebeat'"
$service.StartService()

# Workaround to maintain long running process inside docker container
Get-EventLog -LogName System -After (Get-Date).AddHours(-1) | Format-List ;
$idx = (get-eventlog -LogName System -Newest 1).Index; 
while ($true) 
{ 
    start-sleep -Seconds 1; 
    $idx2  = (Get-EventLog -LogName System -newest 1).index; 
    get-eventlog -logname system -newest ($idx2 - $idx) |  Sort-Object index | Format-List; 
    $idx = $idx2; 
}
  