FROM badlandsmodel/badlands:latest
MAINTAINER Tristan Salles

##################################################
# Non standard as the files come from the packages

USER root

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    gettext && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /live

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER} || true  # dont worry about the error ... keep building

RUN addgroup jovyan  || true
RUN usermod -a -G jovyan jovyan || true

RUN mkdir -p /usr/local/files && chown -R jovyan:jovyan /usr/local/files
ADD --chown=jovyan:jovyan scripts  /usr/local/files
ENV PATH=/usr/local/files:${PATH}

RUN rm -rf /live/lib /live/companion /live/examples /live/workshop

WORKDIR /live
ADD --chown=jovyan:jovyan Notebooks .

# change ownership of everything
ENV NB_USER jovyan
RUN chown -R jovyan:jovyan /home/jovyan
USER jovyan


## These are supplied by the build script
## build-dockerfile.sh

ARG IMAGENAME_ARG
ARG PROJ_NAME_ARG=badlands
ARG NB_PORT_ARG=8888
ARG NB_PASSWD_ARG=""
ARG NB_DIR_ARG
ARG START_NB_ARG="StartHere.ipynb"

# The args need to go into the environment so they
# can be picked up by commands/templates (defined previously)
# when the container runs

ENV IMAGENAME=$IMAGENAME_ARG
ENV PROJ_NAME=$PROJ_NAME_ARG
ENV NB_PORT=$NB_PORT_ARG
ENV NB_PASSWD=$NB_PASSWD_ARG
ENV NB_DIR=$NB_DIR_ARG
ENV START_NB=$START_NB_ARG


## NOW INSTALL NOTEBOOKS

# (This is not standard - nothing to do here )

## The notebooks (and other files we are serving up)


# Trust all notebooks
RUN find -name \*.ipynb  -print0 | xargs -0 jupyter trust

# expose notebook port server port 
EXPOSE $NB_PORT

VOLUME /home/jovyan/$NB_DIR/share

# note we use xvfb which to mimic the X display for lavavu
ENTRYPOINT ["/usr/local/bin/xvfbrun.sh"]

# launch notebook
ADD --chown=jovyan:jovyan scripts/run-jupyter.sh scripts/run-jupyter.sh
CMD scripts/run-jupyter.sh
