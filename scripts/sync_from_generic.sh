#!/usr/bin/env bash
cd $(dirname $0)/..
PROJECT="mobyle2"
IMPORT_URL="https://subversion.makina-corpus.net/scrumpy/mobyle2"
cd $(dirname $0)/..
[[ ! -d t ]] && mkdir t
rm -rf t/*
tar xzvf $(ls -1t ~/cgwb/$PROJECT*z) -C t
files="
.gitignore
bootstrap.py
buildout-dev.cfg
buildout-prod.cfg
minitage.buildout-dev.cfg
minitage.buildout-prod.cfg
README.*
etc/
minilays/
"
for f in $files;do
    rsync -aKzv t/$f $f
done
core_folder="src.mrdeveloper/$PROJECT.core"
core="./"
core=""
if [[ ! -e $core_folder ]];then
    core_folder="src/$PROJECT.core"
fi
rsync -azKv t/src/$PROJECT.core/setup.py src.mrdeveloper/$PROJECT.core/setup.py
for i in $core;do
    rsync -azKv t/src/$PROJECT.core/src/$PROJECT/core/$i src.mrdeveloper/$PROJECT.core/src/$PROJECT/core/$i
done
EGGS_IMPORT_URL="$IMPORT_URL/eggs"
sed -re "/\[sources\]/{
        a $PROJECT.core =  svn $EGGS_IMPORT_URL/$PROJECT.core/trunk
}" -i  etc/project/sources.cfg
sed -re "s:(src/)?$PROJECT\.((skin)|(tma)|(core)|(testing))::g" -i etc/project/$PROJECT.cfg
sed -re "/auto-checkout \+=/{
        a \    $PROJECT.core
}"  -i etc/project/sources.cfg
sed -re "/eggs \+=.*buildout:eggs/{
        a \    $PROJECT.core
}"  -i etc/project/$PROJECT.cfg


sed -re "/use=egg:..instance:ep./{
        a \ 
        a \sqlalchemy.url = \${db:scheme}://\${db:user}:\${db:password}@\${db:host}:\${db:port}/\${db:name}
        a \   
}"  -i etc/templates/wsgi/paster.ini.in
cat << EOF >> etc/sys/settings.cfg

[db]
scheme = postgresql+psycopg2
user = mobyle2
password = secret
host = localhost
port = 5438
name = mobyle2
EOF


sed -re "/zcml \+=/{
        a \    $PROJECT.core
}"  -i etc/project/$PROJECT.cfg
sed -re "s/.*:default/    ${PROJECT}.core:default/g" -i  etc/project/$PROJECT.cfg
sed -re "s/(extends=.*)/\1 etc\/sys\/settings-prod.cfg/g" -i buildout-prod.cfg
sed -re "/\[buildout\]/ {
aallow-hosts = \${mirrors:allow-hosts}
}" -i etc/base.cfg
sed -re "/\[mirrors\]/ {
aallow-hosts =
a\     *localhost*
a\     *willowrise.org*
a\     *plone.org*
a\     *zope.org*
a\     *effbot.org*
a\     *python.org*
a\     *initd.org*
a\     *googlecode.com*
a\     *plope.com*
a\     *bitbucket.org*
a\     *repoze.org*
a\     *crummy.com*
a\     *minitage.org*
a\     *bpython-interpreter.org*
a\     *stompstompstomp.com*
a\     *ftp.tummy.com*
a\     *pybrary.net*
a\     *www.tummy.com*
a\     *www.riverbankcomputing.com*
a\     *.selenic.com*
}" -i etc/sys/settings.cfg
sed  -re "s/dependencies=/dependencies=git-1.7 subversion-1.6 /g" -i minilays/*/*
# vim:set et sts=4 ts=4 tw=0:
