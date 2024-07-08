#!/bin/sh
echo "Building docker cli..."
docker buildx bake --set "binary.platform=${HOSTOS}/${HOSTARCH}"
mkdir /egress
cp build/docker /egress
chmod +x /egress/docker
##