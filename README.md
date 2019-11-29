Usage:


```text

$ docker run -v /etc/hosts:/etc/hosts \
             -v /var/run/docker.sock:/var/run/docker.sock \
             --name 'resolver' \
             --restart always \
             unera/docker-resolver

$ ping resolver

```

Environment:

`REFRESH_INTERVAL` (default value is 10) - interval to recheck `docker ps` list.
