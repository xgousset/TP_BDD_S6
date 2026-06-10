## Starting the environment
```bash
docker build .
docker compose up -d
```

### Reinitialise the database
```bash
docker compose down -v
docker compose up -d
```

## Back-ups
### Generate logical dump (SQL dump)
```bash
docker exec -t postgres_but3 pg_dump -U admin_user multi_lang -F p -f /tmp/multi_lang_backup.sql
```
### Create new target database
```bash
docker exec -t postgres_but3 psql -U admin_user multi_lang -c "CREATE DATABASE BUT3_backup;"
```
### Restore backup to target
```bash
docker exec -t postgres_but3 psql -U admin_user -d but3_backup -f /tmp/multi_lang_backup.sql
```

## Targeted restoration
### Dump etudiants table in custom format
```bash
docker exec -t postgres_but3 pg_dump -U admin_user -t etudiant multi_lang -F c -f /tmp/etudiants_only.dump
```
### Create new database to test restore
```bash
docker exec -t postgres_but3 psql -U admin_user multi_lang -c "CREATE DATABASE BUT3_empty;"
```
### Resotre only etudiants table
```bash
docker exec -t postgres_but3 pg_restore -U admin_user -d but3_empty /tmp/etudiants_only.dump
```