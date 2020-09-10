#!/usr/bin/env bash

APPNAME="hub"

# install portainer
dockermgr install portainer

# install registry
dockermgr install registry

# install registry frontend
dockermgr install registry-web

rm -Rf "$HOMEDIR/$APPNAME"
