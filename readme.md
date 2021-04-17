## ECS FARGATE BASE

This repository provides base docker images meant to be used with projects running on ECS Fargate. Since we can't shell
into underlying Fargate EC2 instances and run `docker exec`, we can't shell into our containers unless the image has ssh
service baked in. So put simply, the images provided by this repo have logic to configure and start openssh before
starting the main downstream application process.

The docker images are actually built on top of official images for particular runtimes like python and node. Currently,
those are the only two supported runtimes, but that list can be expanded in the future. Also, the images are based on
the `slim` versions of those runtimes. It's possible to expand to `alpine` as well with another dockerfile. 

### Example Build
```sh
docker build -t openssh:python-3.7.9-slim --build-arg BASE=python --build-arg VERSION=3.7.9 docker/slim
docker run -it -e ENABLE_SSH=0 -e AUTHORIZED_KEYS="`cat ~/.ssh/{keypair}.pub`" openssh:python-3.7.9-slim
docker run -p 22:22 -e AUTHORIZED_KEYS="`cat ~/.ssh/{keypair}.pub`" openssh:python-3.7.9-slim sleep 300
# ssh -i ~/.ssh/{keypair} ssh-user@localhost
```

[dockerhub-builds-1]: https://blog.thesparktree.com/docker-hub-matrix-builds
