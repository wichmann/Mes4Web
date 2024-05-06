# Mes4Web
vgl. [sfmMES](https://sayk.de/mes-download)

## Build-Toolchain
- maven
- openjdk

### Windows (via [Chocolatey](https://chocolatey.org/install#individual))
- Start > Windows PowerShell > Rechtsklick > Als Administrator ausführen
- `choco install -y maven openjdk`

## Build-Prozess
    cd ./Mes4Web/
    mvn package

## Deployment - __TODO__
- erstes Mal: via `docker compose`
- Updates danach: `Mes4Web*.war`-Datei in `tomcat/webapps/` ersetzen
