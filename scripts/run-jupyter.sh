#!/usr/bin/env sh

PASS=${NB_PASSWD:-""}
OPEN=${START_NB:-""}
PORT=${NB_PORT:-8888}
#
cd /live

jupyter notebook --port=8888 --ip='0.0.0.0' --no-browser --allow-root \
  --NotebookApp.token='' --NotebookApp.default_url="/tree"

# Don't exit

while true; do
  sleep 600
done
