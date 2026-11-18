# Starting state: two Wakapi servers with data

Two small teams each ran their own [Wakapi](https://github.com/muety/wakapi) 2.18.2 server (SQLite).
This folder holds both deployments as they were handed over: the compose file and the database of each.
All people, projects and addresses in the data are made up.

| | folder | port | server time zone |
|---|---|---|---|
| team A | `team-a` | 3000 | Europe/Budapest |
| team B | `team-b` | 3001 | America/New_York |

## Set up

Needs Docker and curl.

```sh
./setup.sh
```

It copies the two folders to `~/wakapi-a` and `~/wakapi-b` and starts both servers.
The only change from the original deployments is that team B listens on port 3001 and the
containers are called `wakapi-a` and `wakapi-b`, so both can run on one machine.
