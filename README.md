# Base Docker Container

https://hub.docker.com/u/badlandsmodel/

### Local installation

```
docker build -t badlandsmodel/badlands-base:python3 -f Dockerfile-base .
```

### Pushing the containers registry


```
docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PASSWORD
docker push badlandsmodel/badlands-base:python3
```
