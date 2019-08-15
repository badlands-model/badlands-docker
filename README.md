Badlands - Basin & Landscape Dynamics
=====

[![code](https://img.shields.io/badge/code-badlands-orange)](https://pypi.org/project/badlands)
[![PyPI](https://img.shields.io/pypi/v/badlands)](https://pypi.org/project/badlands)
[![code](https://img.shields.io/badge/code-companion-orange)](https://pypi.org/project/badlands-companion)
[![PyPI](https://img.shields.io/pypi/v/badlands-companion)](https://pypi.org/project/badlands-companion)


[![Documentation Status](https://readthedocs.org/projects/badlands/badge/?version=latest)](https://badlands.readthedocs.io/en/latest/?badge=latest)      [![DOI](https://zenodo.org/badge/51286954.svg)](https://zenodo.org/badge/latestdoi/51286954)


[![Docker Pulls](https://img.shields.io/docker/pulls/badlandsmodel/pybadlands-demo-dev)](https://cloud.docker.com/u/badlandsmodel/repository/docker/badlandsmodel/badlands)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/badlands-model/badlands-docker/binder?filepath=Dockerfile)

<div align="center">
    <img width=1000 src="https://github.com/badlands-model/badlands/blob/master/badlands/docs/img/view.jpg?raw=true" alt="sketch Badlands" title="sketch of Badlands range of models."</img>
</div>


> DockerHub website [link](https://hub.docker.com/u/badlandsmodel/)

# Base Docker Container

### Local installation

```
docker build -t badlandsmodel/badlands-base:python3 -f Dockerfile-base .
```

### Pushing the containers registry

```
docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PASSWORD
docker push badlandsmodel/badlands-base:python3
```

# Base Code Container

### Local installation

```
docker build -t badlandsmodel/badlands:latest -f Dockerfile-code .
```

### Pushing the containers registry

```
docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PASSWORD
docker push badlandsmodel/badlands:latest
```
