#!/bin/sh

errorExit() {
    echo "*** $*" 1>&2
    exit 1
}
curl --silent --max-time 2 --insecure https://localhost:8443/ -o /dev/null || errorExit "Error GET https://localhost:8443/"

if ip addr | grep -q 172.16.4.80; then
    curl --silent --max-time 2 --insecure https://172.16.4.80:8443/ -o
    /dev/null || errorExit "Error GET https://172.16.4.80:8443/"
fi
