#!/bin/bash


if ! test -z "$1"; then
    exec "$@"
fi

set -e

MARKER='##- container.resolver -##'
TEMPFILE=`tempfile`


cleanup() {
   grep -v "$MARKER" /etc/hosts > $TEMPFILE
   cat $TEMPFILE > /etc/hosts
   rm -f $TEMPFILE
}

trap "cleanup; exit" EXIT INT TERM


while true; do

    grep -v "$MARKER" /etc/hosts > $TEMPFILE

    docker ps| while read line; do


        id=`echo $line|awk '{print $1}'`
        name=`echo $line|awk '{print $NF}'`
        ip=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 2>/dev/null $id || true`

        if test -z "$ip"; then
            continue
        fi

        printf  "%-15s %s %-25s $MARKER\n" $ip    $id $name >> $TEMPFILE
    done

    EXISTS=`md5sum /etc/hosts|awk '{print $1}'`
    NEW=`md5sum $TEMPFILE|awk '{print $1}'`

    if ! test $NEW = $EXISTS; then
        cat $TEMPFILE > /etc/hosts
    fi

    sleep ${REFRESH_INTERVAL-10}
done
