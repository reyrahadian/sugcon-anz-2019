# escape=`
FROM akqahub.azurecr.io/sitecore-xm1-cm:9.2.0-windowsservercore-1903

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"] 

# Download Spinner
RUN Invoke-WebRequest -Uri 'https://github.com/ticketmaster/spinner/releases/download/v1.0.8/spinner_windows_amd64-v1.0.8.zip' -OutFile /spinner.zip; `
    Expand-Archive -Path /spinner.zip -DestinationPath c:/spinner; `
    Rename-Item -Path "C:/spinner/spinner_v1.0.8.exe" -NewName spinner.exe; `
    Remove-Item -Path spinner.zip

# install VS 2019 remote tools
ADD https://aka.ms/vs/16/release/RemoteTools.amd64ret.enu.exe c:/inetpub/sc
RUN c:\inetpub\sc\RemoteTools.amd64ret.enu.exe /quiet /norestart; `
	while(ps RemoteTools*) { Start-Sleep -Seconds 5 }; `
	Remove-Item c:/inetpub/sc/RemoteTools.amd64ret.enu.exe   

WORKDIR C:/inetpub/sc

ADD scripts /Sitecore/Scripts

EXPOSE 4020 4021

USER ContainerAdministrator

ENTRYPOINT c:/Sitecore/Scripts/Boot.ps1