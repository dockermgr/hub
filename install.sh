#!/usr/bin/env bash

mkdir -p /srv/docker/registry && chmod -Rf 777 /srv/docker/registry
mkdir -p /srv/docker/portainer && chmod -Rf 777 /srv/docker/portainer
mkdir -p /srv/docker/registry-web && chmod -Rf 777 /srv/docker/registry-web

# install portainer
docker run -d -p 127.0.0.1:9010:9000 \
--restart always \
--name portainer \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /srv/docker/portainer:/data \
portainer/portainer-ce

# install registry
docker run -d \
-p 5000:5000 \
--restart=always \
--name registry \
-v /srv/docker/registry:/var/lib/registry \
-e SEARCH_BACKEND=sqlalchemy \
-v /etc/ssl/CA:/etc/ssl/CA \
-e REGISTRY_HTTP_TLS_CERTIFICATE=/etc/ssl/CA/CasjaysDev/certs/localhost.crt \
-e REGISTRY_HTTP_TLS_KEY=/etc/ssl/CA/CasjaysDev/private/localhost.key \
registry

# install registry frontend
docker run --name registry-web \
-d --restart=always \
-e ENV_DOCKER_REGISTRY_HOST=$HOSTNAME \
-e ENV_DOCKER_REGISTRY_PORT=5000 \
-e ENV_REGISTRY_PROXY_FQDN=$HOSTNAME \
-e ENV_REGISTRY_PROXY_PORT=443 \
-e ENV_DEFAULT_REPOSITORIES_PER_PAGE=50 \
-e ENV_MODE_BROWSE_ONLY=false \
-e ENV_DEFAULT_TAGS_PER_PAGE=20 \
-e ENV_DOCKER_REGISTRY_USE_SSL=1 \
-e ENV_USE_SSL=1 \
-v /srv/docker/registry-web:/var/lib/registry \
-v /etc/ssl/CA/CasjaysDev/certs/localhost.crt:/etc/apache2/server.crt:ro \
-v /etc/ssl/CA/CasjaysDev/private/localhost.key:/etc/apache2/server.key:ro \
-p 7080:80 \
-p 7081:443 \
konradkleine/docker-registry-frontend:v2
