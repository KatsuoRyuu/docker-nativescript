FROM debian:latest


RUN apt-get update
RUN mkdir -p /usr/share/man/man1

# Update image & install application dependant packages.
RUN apt-get update && apt-get install -y \
    nano \
    libxext6 \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libmcrypt-dev \
    libxslt-dev \
    libpcre3-dev \
    libxrender1 \
    libfontconfig \
    uuid-dev \
    ghostscript \
    curl \
    wget \
    ca-certificates-java \
    gnupg1

RUN apt-get install -y default-jdk-headless

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get install -y --no-install-recommends nodejs npm unzip

RUN useradd -ms /bin/bash nativescript

RUN /bin/bash
RUN echo $0

RUN /bin/bash -c "echo y | npm install -g nativescript"; exit 0;
RUN /bin/bash -c "if [ -d /root/.npm/_logs/ ]; then cat /root/.npm/_logs/*; fi"
RUN /bin/bash -c "if [ ! `which tns` ]; then echo 'unable to find tns'; exit 1; fi"

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools-linux-4333796.zip -d /opt/sdkmanager/
RUN /bin/bash -c "( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /opt/sdkmanager/tools/android update sdk --no-ui -a --filter platform-tool,build-tools-22.0.1,android-22"


USER nativescript
WORKDIR /home/nativescript

USER root
