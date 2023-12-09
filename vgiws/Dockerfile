FROM python:3.7.4

WORKDIR /usr/src/vgiws

COPY . /usr/src/vgiws

# Lines to avoid problems related to build image (https://github.com/phusion/baseimage-docker/issues/319)
# ENV DEBIAN_FRONTEND noninteractive
# ENV DEBIAN_FRONTEND teletype
# RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    software-properties-common \
    python-gdal \
    python3-gdal \
    gdal-bin \
    libpq-dev \
    python3-dev \
    build-essential

RUN pip install --no-cache-dir -r requirements.txt

ENV TZ=America/Sao_Paulo

EXPOSE 8888

CMD [ "python", "main.py" ]
