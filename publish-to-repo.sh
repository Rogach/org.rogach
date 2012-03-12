#!/bin/bash

name=`sed -n 's_\s*name\s*:=\s*"\(.*\)"_\1_p' build.sbt`
version=`sed -n 's_\s*version\s*:=\s*"\(.*\)"_\1_p' build.sbt`
scalaVersion=`sed -n 's_\s*scalaVersion\s*:=\s*"\(.*\)"_\1_p' build.sbt`
sbt publish-local
mkdir -p /home/platon/sync/org.rogach/org/rogach/${name}/${version}/
cp ~/.ivy2/local/default/${name}_${scalaVersion}/${version}/jars/${name}_${scalaVersion}.jar \
  /home/platon/sync/org.rogach/org/rogach/${name}/${version}/${name}-${version}.jar
cat ~/.ivy2/local/default/${name}_${scalaVersion}/${version}/poms/${name}_${scalaVersion}.pom \
  | sed 's/<groupId>default<\/groupId>/<groupId>org.rogach<\/groupId>/' \
  | sed "s/<artifactId>${name}_${scalaVersion}<\/artifactId>/<artifactId>${name}<\/artifactId>/" \
  > /home/platon/sync/org.rogach/org/rogach/${name}/${version}/${name}-${version}.pom
cd /home/platon/sync/org.rogach/
git add .
git commit -m "updated repository"
bzr commit -m "updated repository"
git push