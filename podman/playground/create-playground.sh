#!/bin/bash

# create a network
# podman network create --subnet 192.168.242.64/28 --gateway 192.168.242.65 play-mirco

# pod with shared setup over all containers
podman pod create --name play-mirco \
  --volume=./mirco/mirco.yml:/rails/shared/config/mirco.yml:ro,z \
  --publish=3001:3001 \
  --label=group=mirco-playground

podman create --pod play-mirco --name play-mirco-redis \
  --volume play-mirco-redis:/data \
  docker.io/library/redis:latest

podman create --pod play-mirco --name play-mirco-postgres \
  --volume=play-mirco-postgres:/var/lib/postgresql/data \
  --env-file=./mirco/env.playground \
  --health-cmd="/usr/local/bin/pg_isready -q -d postgres -U postgres" \
  --health-interval=10s \
  --health-timeout=45s \
  --health-retries=10 \
  docker.io/timescale/timescaledb:latest-pg16

podman create --pod play-mirco --name play-mirco-app \
  --requires=play-mirco-redis,play-mirco-postgres \
  --env-file=./mirco/env.playground \
  --env="FORCE_SSL=false" \
  --cap-add=CAP_NET_RAW \
  --volume=play-mirco-storage:/rails/storage \
  ghcr.io/swobspace/mirco:0.1.1

  
