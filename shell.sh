#!/usr/bin/env bash
cd $(dirname $0)
bin/pshell etc/wsgi/instance.ini#projectapp $@

# vim:set et sts=4 ts=4 tw=80:
