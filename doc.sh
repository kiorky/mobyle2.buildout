#!/usr/bin/env bash
cd $(dirname $0)
cd src.mrdeveloper/mobyle2.github.com
git pull
make html
git add .
git commit -am "updating docs"
git push --all p
# vim:set et sts=4 ts=4 tw=80:
