FROM debian:buster
RUN apt-get -qy update
RUN apt-get -qy install bash docker.io

COPY docker-hosts.sh /usr/local/bin

ENTRYPOINT ["/bin/bash", "/usr/local/bin/docker-hosts.sh"]

