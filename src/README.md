# Build application
## Create SQL database container
1. Start container

```bash
docker compose -f 'src/Docker-Compose.yaml' up -d --build
```
2. Access database
```bash
docker exec -it mssql_db "bash"
/opt/mssql-tools18/bin/sqlcmd -S localhost -U mssql -P "YourStrong@Passw0rd"
```