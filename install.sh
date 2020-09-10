#!/usr/bin/env bash

# install portainer
dockermgr install portainer

# install registry
dockermgr install registry

# install registry frontend
dockermgr install registry-web

rm -Rf "$APPDIR"
