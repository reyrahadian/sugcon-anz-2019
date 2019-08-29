# escape=`
FROM mcr.microsoft.com/windows/servercore:1903

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# download FileBeat
RUN Invoke-WebRequest -Uri 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.3.0-windows-x86_64.zip' -OutFile /metricbeat.zip; `
    Expand-Archive -Path /metricbeat.zip -DestinationPath /temp; `
    Move-Item -Path "C:/temp/metricbeat-*" -Destination c:\metricbeat; `
    Remove-Item -Path metricbeat.zip

USER ContainerAdministrator 

COPY metricbeat.yml /metricbeat/

COPY boot.ps1 /metricbeat/

VOLUME [ "c:/data","c:/logs" ]

WORKDIR /metricbeat

CMD .\boot.ps1