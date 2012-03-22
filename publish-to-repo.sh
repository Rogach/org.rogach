#!/bin/bash

name=`sed -n 's_\s*name\s*:=\s*"\(.*\)"_\1_p' build.sbt`
version=`sed -n 's_\s*version\s*:=\s*"\(.*\)"_\1_p' build.sbt`
scalaVersion=`sed -n 's_\s*scalaVersion\s*:=\s*"\(.*\)"_\1_p' build.sbt`
sbt +compile +publish-local
for sVersion in 2.9.0 2.9.0-1 2.9.1
do
  mkdir -p /home/platon/sync/org.rogach/org/rogach/${name}_${sVersion}/${version}/
  cp ~/.ivy2/local/default/${name}_${sVersion}/${version}/jars/${name}_${sVersion}.jar \
    /home/platon/sync/org.rogach/org/rogach/${name}_${sVersion}/${version}/${name}_${sVersion}-${version}.jar
  cat ~/.ivy2/local/default/${name}_${sVersion}/${version}/poms/${name}_${sVersion}.pom \
    | sed 's/<groupId>default<\/groupId>/<groupId>org.rogach<\/groupId>/' \
    > /home/platon/sync/org.rogach/org/rogach/${name}_${sVersion}/${version}/${name}_${sVersion}-${version}.pom
done
cd /home/platon/sync/org.rogach/
git add .
git commit -m "updated repository"
bzr add
bzr commit -m "updated repository"
git push