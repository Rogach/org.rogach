#!/bin/bash

name=`sed -n 's_\s*name\s*:=\s*"\(.*\)"_\1_p' build.sbt`
version=`sed -n 's_\s*version\s*:=\s*"\(.*\)"_\1_p' build.sbt`
scalaVersion=`sed -n 's_\s*scalaVersion\s*:=\s*"\(.*\)"_\1_p' build.sbt`
sbt +compile +publish-local
for sVersion in $(cat build.sbt  | grep cross | grep -Po '\d\.\d\.\d[^-]|\d\.\d\.\d-\d[^-]' | while read x; do echo "${x%?}"; done)
do
  mkdir -p /home/platon/sync/org.rogach/org/rogach/${name}_${sVersion}/${version}/
  cp ~/.ivy2/local/org.rogach/${name}_${sVersion}/${version}/jars/${name}_${sVersion}.jar \
    /home/platon/sync/org.rogach/org/rogach/${name}_${sVersion}/${version}/${name}_${sVersion}-${version}.jar
  cp ~/.ivy2/local/org.rogach/${name}_${sVersion}/${version}/poms/${name}_${sVersion}.pom \
    /home/platon/sync/org.rogach/org/rogach/${name}_${sVersion}/${version}/${name}_${sVersion}-${version}.pom
done
cd /home/platon/sync/org.rogach/
git add .
git commit -m "updated repository"
bzr add
bzr commit -m "updated repository"
git push