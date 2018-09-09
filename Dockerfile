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

ENV ANDROID_HOME /opt/sdkmanager/
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin

RUN echo 'export ANDROID_HOME=/opt/sdkmanager' >> /etc/profile
RUN echo 'export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin' >> /etc/profile

RUN touch /tmp/sdkmanager.log
RUN /bin/bash -c 'yes | sdkmanager --licenses'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "tools" "platform-tools" >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "extras;android;m2repository" >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "build-tools;22.0.1" "platforms;android-22" >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "build-tools;23.0.2" "platforms;android-23" >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "build-tools;26.0.3" "platforms;android-26" >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "build-tools;27.0.3" "platforms;android-27" >> /tmp/sdkmanager.log'

USER nativescript
WORKDIR /home/nativescript

USER root
