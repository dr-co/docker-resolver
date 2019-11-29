Usage:


```text

$ docker run -v /etc/hosts:/etc/hosts \
             -v /var/run/docker.sock:/var/run/docker.sock \
             --name 'resolver' \
             --restart always \
             unera/docker-resolver

$ ping resolver

```

