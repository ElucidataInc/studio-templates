FROM mithoopolly/data-studio:studio-requirements-v1 AS studio-req
WORKDIR /studio

FROM mithoopolly/ipython-r-docker:1.0.0
WORKDIR /studio
USER root

RUN apt-get update -y --no-install-recommends && \
    apt-get install -y --no-install-recommends libzmq3-dev libcurl4-openssl-dev libssl-dev

RUN apt-get install -y --no-install-recommends libgmp3-dev && \
    apt-get install -y --no-install-recommends libpoppler-cpp-dev && \
    apt-get install -y --no-install-recommends libglu1-mesa-dev freeglut3-dev mesa-common-dev libfreetype6-dev libmagick++-dev

COPY temp/ .

RUN pip install --upgrade pip

# -------------Package installations-------------

RUN R -e 'install.packages(c("BiocManager","dplyr","rjson","tidyjson","tidyr","readxl"), repo="https://cloud.r-project.org/")'
RUN R -e 'BiocManager::install(c("clusterProfiler"))'

# ------------------End----------------------

# Package Invoker Installation
COPY --from=studio-req studio/package-invoker/. ./package-invoker/
RUN ls ./package-invoker
RUN pip3 install -r ./package-invoker/requirements.txt

ENV io_file_URL=xyz

ENV EXE_TYPE=STUDIO
ENV BYPASS_ALGO=NO

RUN ls -l
ENTRYPOINT ["bash", "./docker_run.sh"]