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

echo y | npm install nativescript --unsafe-perm

wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip sdk-tools-linux-4333796.zip -d /opt/sdkmanager/
( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /opt/sdkmanager/tools/android update sdk --no-ui -a --filter platform-tool,build-tools-22.0.1,android-22


USER nativescript
WORKDIR /home/nativescript
