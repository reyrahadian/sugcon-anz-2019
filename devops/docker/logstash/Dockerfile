# escape=`
FROM mcr.microsoft.com/windows/servercore:1903

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# download JAVA
ENV JAVA_HOME C:\\ojdkbuild
ENV JAVA_OJDKBUILD_VERSION 1.8.0.191-1
ENV JAVA_OJDKBUILD_ZIP java-1.8.0-openjdk-1.8.0.191-1.b12.ojdkbuild.windows.x86_64.zip

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -Uri $('https://github.com/ojdkbuild/ojdkbuild/releases/download/{0}/{1}' -f $env:JAVA_OJDKBUILD_VERSION, $env:JAVA_OJDKBUILD_ZIP) -UseBasicParsing -OutFile 'ojdkbuild.zip'; `
    Expand-Archive ojdkbuild.zip -DestinationPath C:\; `
    Move-Item -Path ('C:\\{0}' -f ($env:JAVA_OJDKBUILD_ZIP -Replace '.zip', '')) -Destination $env:JAVA_HOME;

# download Elastic Search
RUN Invoke-WebRequest -Uri 'https://artifacts.elastic.co/downloads/logstash/logstash-7.3.0.zip' -OutFile /logstash.zip; `
    Expand-Archive -Path /logstash.zip -DestinationPath /temp; `
    Move-Item -Path "C:/temp/logstash-*" -Destination c:\logstash; `
    Remove-Item -Path logstash.zip

RUN setx /M PATH '%JAVA_HOME%\bin;%PATH%'

USER ContainerAdministrator 

COPY logstash.conf /logstash/config/

VOLUME [ "c:/data","c:/logs" ]

ENV LS_HOME c:/logstash

CMD [ "cmd","/c","c:\\logstash\\bin\\logstash.bat -f c:\\logstash\\config\\logstash.conf --path.data c:\\data --path.logs c:\\logs" ]

EXPOSE 5044 9600