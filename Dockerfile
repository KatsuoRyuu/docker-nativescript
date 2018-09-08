FROM debian:stretch-slim


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

RUN apt-get install -y --no-install-recommends android-sdk nodejs npm
RUN echo y | npm install -g nativescript --unsafe-perm ; exit 0;
RUN ls -lah /usr/lib/node_modules/.nativescript.DELETE/node_modules/
RUN ls -lah /root/.npm/_logs/
RUN cat /root/.npm/_logs/*

RUN useradd -ms /bin/bash nativescript

USER nativescript
WORKDIR /home/nativescript

RUN echo y | npm install nativescript --unsafe-perm
RUN $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools" "platforms;android-26" "build-tools;26.0.2" "extras;android;m2repository" "extras;google;m2repository" > /dev/null
RUN npm i