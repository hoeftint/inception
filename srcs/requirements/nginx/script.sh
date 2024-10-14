#! /bin/bash

docker build -t nginx:1 .
docker run -dp 8080:443 nginx:1