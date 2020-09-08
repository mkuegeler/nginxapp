#!/bin/sh
# Run docker commands

# 1. Set variables
REPO="mkuegeler/nginxapp:latest"
IMAGE="nginx-alpine-image"
CONTAINER="nginx-alpine-container"
HOST="localhost"
INTERNAL_PORT="80"
EXTERNAL_PORT="8081"

# 2. Build image
build_image()
{
  docker build -t $IMAGE .
}

# 3. Run container with local Dockerfile
local_run()
{
  docker run --name $CONTAINER -d -p $EXTERNAL_PORT:$INTERNAL_PORT $IMAGE
}

# 4. Run container with image from repo
repo_run()
{
  docker run --name $CONTAINER -d -p $EXTERNAL_PORT:$INTERNAL_PORT $REPO
}

# 5. Stop container
stop()
{
  docker stop $CONTAINER
}
 
# 6. Remove container
rm()
{
  docker rm $CONTAINER
}

# 7. Remove image
rmi()
{
  docker rmi $IMAGE
}

# Get parameters and run functions

if [ "$1" == "" ]; then
    echo "Run script with parameters: build_image, local_run, repo_run, stop, rm, rmi"
fi

if [ "$1" == "build_image" ]; then
    build_image
fi

if [ "$1" == "local_run" ]; then
    local_run
    echo "http://$HOST:$EXTERNAL_PORT"
fi

if [ "$1" == "repo_run" ]; then
    repo_run
    echo "http://$HOST:$EXTERNAL_PORT"
fi

if [ "$1" == "stop" ]; then
    stop
fi

if [ "$1" == "rm" ]; then
    rm
fi

if [ "$1" == "rm" ]; then
    rmi
fi