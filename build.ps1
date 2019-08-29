param(
    [switch]$shouldPushDockerImages = $false
)
$ErrorActionPreference = "Stop"

$containerRegistry = "akqahub.azurecr.io"

Write-Host "Build and push applications docker images" -ForegroundColor Yellow 
Get-ChildItem -Path .\devops\docker -Recurse -Include "build.json" | ForEach-Object {
    $config = Get-Content -Path $_.FullName | ConvertFrom-Json    
    $dockerFilePath = $_.FullName.Replace("build.json","DockerFile")
    Write-Host "Building $($_.DirectoryName)" -ForegroundColor Yellow
    docker build -t $config.tag -f $dockerFilePath $_.DirectoryName
    
    if($shouldPushDockerImages){
        docker tag $config.tag "$containerRegistry/$($config.tag)"
        docker push "$containerRegistry/$($config.tag)"
    }
}

$artifactsFolderPath = ".\artifacts"
if(!(Test-Path $artifactsFolderPath)){
    #cm and cd containers are failing if this folder doesnt exist.
    New-Item -ItemType Directory -Path $artifactsFolderPath
}