FROM mcr.microsoft.com/windows/servercore:1903 as core

FROM mcr.microsoft.com/windows/nanoserver:1903
COPY --from=core /windows/system32/netapi32.dll /windows/system32/netapi32.dll

ENV TRAEFIK_VERSION 1.7.14

WORKDIR /traefik

ADD https://github.com/containous/traefik/releases/download/v${TRAEFIK_VERSION}/traefik_windows-amd64.exe traefik.exe

EXPOSE 80 443 8080

USER ContainerAdministrator

VOLUME [ "c:/traefik/config" ]

ENTRYPOINT ["/traefik/traefik.exe"]

# Metadata
LABEL org.label-schema.vendor="Containous" \
      org.label-schema.url="https://traefik.io" \
      org.label-schema.name="Traefik" \
      org.label-schema.description="A modern reverse-proxy" \
      org.label-schema.version="v${TRAEFIK_VERSION}" \
      org.label-schema.docker.schema-version="1.0"
