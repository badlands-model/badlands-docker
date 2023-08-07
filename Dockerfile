FROM continuumio/anaconda3
MAINTAINER "Tristan Salles"
RUN apt-get update 
RUN /opt/conda/bin/conda config --env --add channels defaults 
RUN /opt/conda/bin/conda config --env --add channels conda-forge 
RUN /opt/conda/bin/conda config --env --add channels anaconda
RUN /opt/conda/bin/conda update -n base -c defaults conda 
RUN /opt/conda/bin/conda install python=3.8 -y 
RUN /opt/conda/bin/conda install anaconda-client -y 
RUN /opt/conda/bin/conda install jupyter -y 
RUN /opt/conda/bin/conda install numpy pandas scikit-learn scikit-image seaborn h5py -y 
RUN /opt/conda/bin/conda install compilers gfortran netCDF4 -y 
RUN /opt/conda/bin/conda install pillow scipy descartes pyvista -y
RUN /opt/conda/bin/conda install meshplex -y 
RUN /opt/conda/bin/conda install make -y 
RUN /opt/conda/bin/conda install pyvirtualdisplay -y
RUN /opt/conda/bin/conda install gflex -y
RUN /opt/conda/bin/conda install cmocean -y
RUN /opt/conda/bin/conda install -c "conda-forge/label/cf201901" triangle -y
RUN /opt/conda/bin/conda install colorlover
RUN /opt/conda/bin/conda install pyevtk
RUN apt-get install -yq --no-install-recommends \ 
    build-essential \
    mesa-utils \
    libglu1-mesa-dev \
    libosmesa6-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    zlib1g-dev
RUN /opt/conda/bin/conda update jupyter
RUN pip install nbconvert --upgrade
RUN pip install lavavu
RUN pip install triangle
# Install badlands
RUN ["mkdir", "/usr/lib64/"]
RUN ln -s /opt/conda/x86_64-conda-linux-gnu/sysroot/lib64/librt.so.1 /lib64/librt.so.1
RUN ln -s /opt/conda/x86_64-conda-linux-gnu/sysroot/usr/lib64/libc_nonshared.a /usr/lib64/libc_nonshared.a
RUN ln -s /opt/conda/x86_64-conda-linux-gnu/sysroot/lib64/libc.so.6 /lib64/libc.so.6 
RUN ln -s /opt/conda/x86_64-conda-linux-gnu/sysroot/lib64/libpthread.so.0 /lib64/libpthread.so.0
RUN ln -s /opt/conda/x86_64-conda-linux-gnu/sysroot/usr/lib64/libpthread_nonshared.a /usr/lib64/libpthread_nonshared.a
COPY packages/badlands /root/badlands
RUN cd /root/badlands/; python3 setup.py install
# Install companion
COPY packages/companion /root/companion
RUN cd /root/companion/; python3 setup.py install
# Define shared volume folder
RUN ["mkdir", "main"]
RUN ["mkdir", "main/notebooks"]
# Add workshop
COPY packages/workshop main/workshop
# LavaVu stuff
RUN apt-get install -yq --no-install-recommends xvfb
RUN pip install xvfbwrapper
# BASH command
ADD conf/bashrc-term /root/.bashrc
COPY conf/.jupyter /root/.jupyter
COPY run_jupyter.sh /
# Jupyter port
EXPOSE 8888
# Store notebooks in this mounted directory
VOLUME /main/notebooks
CMD ["/run_jupyter.sh"]
