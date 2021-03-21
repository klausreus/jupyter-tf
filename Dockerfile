# use ml jupyter base notebook
FROM jupyter/tensorflow-notebook:latest

# enable jupyterlab as default app
ENV JUPYTER_ENABLE_LAB=true

#deal with matlplotlib cache warning
ENV XDG_CACHE_HOME='${HOME}/.cache/'

# Install from requirements.txt file with conda
COPY requirements.txt /tmp/
RUN conda install -c conda-forge --yes --update-deps --file /tmp/requirements.txt && \
    # Install pip-only packages
    #pip install tensorflow-addons && \
    # Build Jupyterlab extensions
    #jupyter labextension install -y --clean --no-build \
     #   jupyterlab-jupytext dask-labextension @pyviz/jupyterlab_pyviz && \
    #jupyter lab build && \
    # clean conda cache, index and package tarballs
    conda clean -a && \
    # fix file permissions
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
    
