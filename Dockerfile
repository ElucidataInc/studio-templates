FROM mithoopolly/data-studio:studio-requirements-r-0.2.5
WORKDIR /studio

USER root

# Python 3 installations
RUN pip install --upgrade pip

RUN R -e 'install.packages(c("tidyjson","tidyr","readxl"), repo="https://cloud.r-project.org/")'

#RUN R -e 'BiocManager::install(c("gage"))'

COPY temp/ .

RUN cp -r ./viz/. ./algorithm/viz/

RUN ls -l
ENTRYPOINT ["bash", "./docker_run.sh"]
