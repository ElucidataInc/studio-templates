FROM mithoopolly/data-studio:studio-requirements-v1 AS studio-req
WORKDIR /studio

FROM mithoopolly/ipython-py3-docker:3.0.0
WORKDIR /studio
USER root

RUN apt-get update -y --no-install-recommends && \
    apt-get install -y --no-install-recommends libzmq3-dev libcurl4-openssl-dev libssl-dev

RUN apt-get install -y --no-install-recommends libgmp3-dev && \
    apt-get install -y --no-install-recommends libpoppler-cpp-dev && \
    apt-get install -y --no-install-recommends libglu1-mesa-dev freeglut3-dev mesa-common-dev libfreetype6-dev libmagick++-dev &&\
    apt-get install -y --no-install-recommends libpython3-dev build-essential

COPY code/ .

# Python 3 installations
RUN pip install --upgrade pip

# -------------Package installations-------------

COPY --from=studio-req studio/docker_run_py.sh ./docker_run.sh
RUN pip3 install -r ./algorithm/requirements.txt --no-dependencies

# ------------------End----------------------

# Package Invoker Installation
COPY --from=studio-req studio/package-invoker/. ./package-invoker/
RUN pip3 install -r ./package-invoker/requirements.txt

ENV io_file_URL=xyz

ENV EXE_TYPE=STUDIO
ENV BYPASS_ALGO=NO

RUN ls -l
ENTRYPOINT ["bash", "./docker_run.sh"]