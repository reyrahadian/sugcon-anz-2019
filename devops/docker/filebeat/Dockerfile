# escape=`
FROM mcr.microsoft.com/windows/servercore:1903

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Download FileBeat
RUN Invoke-WebRequest -Uri 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.3.0-windows-x86_64.zip' -OutFile /filebeat.zip; `
    Expand-Archive -Path /filebeat.zip -DestinationPath /temp; `
    Move-Item -Path "C:/temp/filebeat-*" -Destination c:\filebeat; `
    Remove-Item -Path filebeat.zip

USER ContainerAdministrator 

COPY filebeat.yml /filebeat/

COPY boot.ps1 /filebeat/

VOLUME [ "c:/data","c:/logs","c:/watch-logs" ]

WORKDIR /filebeat

CMD .\boot.ps1