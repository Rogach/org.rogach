#!/bin/bash

perl -pe '$_=~s/\s*version\s*:=\s*"([0-9\.]*\.)(\d*)"/"version := \"" . $1 . ($2 + 1) . "\""/e;' < build.sbt | sponge build.sbt
publish-to-repo.sh