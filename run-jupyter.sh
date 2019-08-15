#
cd /live

jupyter-notebook --port=8888 --ip='0.0.0.0' --no-browser --allow-root \
  --NotebookApp.token='' --NotebookApp.default_url="/tree/StartHere.ipynb"

while true; do
  sleep 600
done
