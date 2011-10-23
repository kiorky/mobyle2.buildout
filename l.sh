#!/usr/bin/env bash
cd $(dirname $0)

while true;do
    ps aux|grep paster|grep mobyle2|awk '{print $2}'|xargs kill -9
    reset
    ./bin/paster serve --reload etc/wsgi/instance.ini
    echo;echo;echo
    echo "--------------------------------------------------------------"
    echo "              Press enter to restart"
    echo "--------------------------------------------------------------"
    read
done           
# vim:set et sts=4 ts=4 tw=80:
