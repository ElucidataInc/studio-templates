FROM docker.polly.elucidata.io/elucidata/studio-requirements-r:latest
WORKDIR /studio

USER root

# Python 3 installations
RUN pip install --upgrade pip

# Add all dependencies between the dashed lines
# -----------------------------------------------------
RUN R -e 'install.packages(c("tidyjson","tidyr","readxl"), repo="https://cloud.r-project.org/")'

#RUN R -e 'BiocManager::install(c("gage"))'
#------------------------------------------------------
COPY temp/ .

RUN cp -r ./viz/. ./algorithm/

RUN ls -l
ENTRYPOINT ["bash", "./docker_run.sh"]
