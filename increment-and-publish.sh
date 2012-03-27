#!/bin/bash

# increments last number of project version in build.sbt and readme
perl -pe '$_=~s/\s*version\s*:=\s*"([0-9\.]*\.)(\d*)"/"version := \"" . $1 . ($2 + 1) . "\""/e;' < build.sbt | sponge build.sbt
perl -pe '$_=~s/%\s"([0-9\.]*\.)(\d*)"/"% " . "\"" . $1 . ($2 + 1) . "\""/e;' < README.md | sponge README.md
publish-to-repo.sh