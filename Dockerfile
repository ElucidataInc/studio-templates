FROM mithoopolly/data-studio:studio-requirements-py3-0.2.5
WORKDIR /studio

USER root

# Python 3 installations
RUN pip install --upgrade pip
RUN pip install Pillow

RUN apt-get install -y --no-install-recommends libpython3-dev build-essential

COPY temp/ .

RUN cp -r ./viz/. ./algorithm/viz/

RUN pip3 install -r ./algorithm/requirements.txt --no-dependencies

RUN ls -l
ENTRYPOINT ["bash", "./docker_run.sh"]
