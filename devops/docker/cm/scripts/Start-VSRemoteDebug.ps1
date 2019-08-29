Write-Host ("{0}: Starting 'msvsmon.exe'..." -f [DateTime]::Now.ToString("HH:mm:ss:fff"))

$args = @("/noauth","/anyuser","/silent","/nostatus","/noclrwarn","/nosecuritywarn","/nofirewallwarn","/nowowwarn","/timeout:2147483646")
& "C:\Program Files\Microsoft Visual Studio 16.0\Common7\IDE\Remote Debugger\x64\msvsmon.exe" @args;

Write-Host ("{0}: Started 'msvsmon.exe'" -f [DateTime]::Now.ToString("HH:mm:ss:fff"))