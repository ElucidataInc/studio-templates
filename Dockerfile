FROM mithoopolly/data-studio:studio-requirements-r-prod-1.0.0 AS studio-req
WORKDIR /studio

FROM mithoopolly/ipython-r-docker:1.0.0
WORKDIR /studio
USER root

RUN apt-get update -y --no-install-recommends && \
    apt-get install -y --no-install-recommends libzmq3-dev libcurl4-openssl-dev libssl-dev

RUN apt-get install -y --no-install-recommends libgmp3-dev && \
    apt-get install -y --no-install-recommends libpoppler-cpp-dev && \
    apt-get install -y --no-install-recommends libglu1-mesa-dev freeglut3-dev mesa-common-dev libfreetype6-dev libmagick++-dev

RUN apt-get install -y --no-install-recommends python3.6-dev

COPY temp/ .

COPY --from=studio-req studio/viz/. ./algorithm/viz/

RUN pip install --upgrade pip

# -------------Package installations-------------

# Add CRAN packages required by the script. Removing the following packages will result in undefined behavior
RUN R -e 'install.packages(c("dplyr","rjson","reticulate", "ggplot2"), repo="https://cloud.r-project.org/")'

# Uncomment next line for Bioconductor package installations
# RUN R -e 'install.packages("BiocManager", repo="https://cloud.r-project.org/")'
# RUN R -e 'BiocManager::install(c("scAlign"))'

# Uncomment next line for devtool package installations
# RUN R -e 'install.packages("devtools", repo="https://cloud.r-project.org/")'
# RUN R -e 'devtools::install_github("r-lib/devtools")'

# ------------------End----------------------

# Package Invoker Installation
COPY --from=studio-req studio/package-invoker/. ./package-invoker/
RUN pip3 install -r ./package-invoker/requirements.txt

COPY --from=studio-req studio/docker_run.sh ./docker_run.sh

ENV io_file_URL=xyz

ENV EXE_TYPE=STUDIO
ENV BYPASS_ALGO=NO

RUN ls -l
ENTRYPOINT ["bash", "./docker_run.sh"]