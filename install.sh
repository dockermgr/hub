#!/usr/bin/env bash

APPNAME="hub"
DOCKER_HUB_URL=

# install portainer
sudo dockermgr install portainer

# install registry
sudo dockermgr install registry

# install registry frontend
sudo dockermgr install registry-web

sudo rm -Rf "$HOME/.local/share/CasjaysDev/dockermgr/$APPNAME"
