# Commands
## Prepare servers
```
$ docker compose up
```

```
$ bin/setup-postgres.sh 15432
$ bin/setup-mysql.sh 13306
$ bin/setup-mysql.sh 23306
```

## Connect to servers
```
$ bin/connect-postgres.sh 15432
$ bin/connect-mysql.sh 13306
$ bin/connect-mysql.sh 23306
```

# References
- latest.json is from moment-timezone
