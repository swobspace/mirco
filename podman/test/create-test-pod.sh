#!/bin/bash
# to be started in Rails.root
if [ ! -r Dockerfile ]; then
  echo "please start script from Rails.root!"
  exit 1
fi

# create image
# podman build -f podman/devel/Dockerfile -t mirco-test .

# pod with shared setup over all containers
podman pod create --name mirco-test \
  --volume=.:/app:z,cached \
  --publish=3001:3001 \
  --publish=4444:4444 \
  --label=group=mirco-test

podman create --pod mirco-test --name mirco-test-redis \
  --volume mirco-test-redis:/data \
  docker.io/library/redis:latest

podman create --pod mirco-test --name mirco-test-postgres \
  --volume=mirco-test-postgres:/var/lib/postgresql/data \
  --env-file=.env.test.local \
  --health-cmd="/usr/local/bin/pg_isready -q -d postgres -U postgres" \
  --health-interval=10s \
  --health-timeout=45s \
  --health-retries=10 \
  docker.io/timescale/timescaledb:latest-pg16

podman create --pod mirco-test --name mirco-test-app \
  --requires=mirco-test-redis,mirco-test-postgres \
  --tmpfs=/app/tmp/pids:rw,size=1024k \
  --env-file=.env.test.local \
  --tty --interactive \
  localhost/mirco-dev bin/dev

podman create --pod mirco-test --name mirco-test-selenium \
  --requires=mirco-test-app \
  --env-file=.env.test.local \
  --env='START_XVFB=false' \
  --shm-size=2gb \
  docker.io/selenium/standalone-chrome:4.15
  # docker.io/selenium/standalone-chrome:latest

