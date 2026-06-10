## Starting the environment
```bash
docker compose up -d
```

## Back-ups
### Generate logical dump (SQL dump)
```bash
docker exec -t postgres_but3 pg_dump -U admin_user multi_lang -F p -f /tmp/multi_lang_backup.sql
```
### Create new target database
```bash
docker exec -t postgres_but3 psql -U admin_user -c "CREATE DATABASE \"BUT3_backup\";"
```
### Restore backup to target
```bash
docker exec -t postgres_but3 psql -U admin_user -d BUT3_backup -f /tmp/multi_lang_backup.sql
```

## Targeted restoration
### Dump etudiants table in custom format
```bash
docker exec -t postgres_but3 pg_dump -U admin_user -t etudiants multi_lang -F c -f /tmp/etudiants_only.dump
```
### Create new database to test restore
```bash
docker exec -t postgres_but3 psql -U admin_user -c "CREATE DATABASE \"BUT3_empty\";"
```
### Resotre only etudiants table
```bash
docker exec -t postgres_but3 pg_restore -U admin_user -d BUT3_empty /tmp/etudiants_only.dump
```