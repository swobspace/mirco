#!/bin/bash
# to be started in Rails.root
if [ ! -r Dockerfile ]; then
  echo "please start script from Rails.root!"
  exit 1
fi

# create image

# podman build -f podman/devel/Dockerfile -t mirco-dev .

# pod with shared setup over all containers
podman pod create --name mirco-dev \
  --volume=.:/app:z,cached \
  --publish=3001:3001 \
  --label=group=mirco-dev

podman create --pod mirco-dev --name mirco-dev-redis \
  --volume mirco-dev-redis:/data \
  docker.io/library/redis:latest

podman create --pod mirco-dev --name mirco-dev-postgres \
  --volume=mirco-dev-postgres:/var/lib/postgresql/data \
  --env-file=.env.development.local \
  --health-cmd="/usr/local/bin/pg_isready -q -d postgres -U postgres" \
  --health-interval=10s \
  --health-timeout=45s \
  --health-retries=10 \
  docker.io/timescale/timescaledb:latest-pg16

podman create --pod mirco-dev --name mirco-dev-app \
  --requires=mirco-dev-redis,mirco-dev-postgres \
  --tmpfs=/app/tmp/pids:rw,size=1024k \
  --env-file=.env.development.local \
  --tty --interactive \
  localhost/mirco-dev bin/dev

podman create --pod mirco-dev --name mirco-dev-worker \
  --requires=mirco-dev-redis,mirco-dev-postgres \
  --env-file=.env.development.local \
  localhost/mirco-dev good_job start

podman create --pod mirco-dev --name mirco-dev-selenium \
  --requires=mirco-dev-app \
  --env='START_XVFB=false' \
  --shm-size=2gb \
  docker.io/selenium/standalone-chrome:4.15
  # docker.io/selenium/standalone-chrome:latest
