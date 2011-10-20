#!/usr/bin/env bash
cd $(dirname $0)
ps aux|grep paster|awk '{print $2}'|xargs kill -9;./bin/paster serve etc/wsgi/instance.ini 
# vim:set et sts=4 ts=4 tw=80:
