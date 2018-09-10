FROM node:10-stretch

ENV ANDROID_HOME /opt/sdkmanager/
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin
ENV TERM xterm-color

RUN apt-get update
RUN mkdir -p /usr/share/man/man1

RUN apt-get update && apt-get install -y --no-install-recommends curl gnupg1
RUN apt-get install -y wget
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

RUN echo y | npm install -g nativescript; exit 0;
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | npm install -g nativescript'; exit 0;
RUN /bin/bash -c "if [ -f /tmp/npm.log ]; then cat /tmp/npm.log; fi"
RUN /bin/bash -c "if [ -d /root/.npm/_logs/ ]; then cat /root/.npm/_logs/*; fi"
RUN /bin/bash -c "if [ ! `which tns` ]; then echo 'unable to find tns'; exit 1; fi"

# Update image & install application dependant packages.
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxext6 \
    libfreetype6-dev \
    libjpeg62-dev \
    libpng-dev \
    libmcrypt-dev \
    libxslt1-dev \
    libpcre3-dev \
    libxrender1 \
    libfontconfig1 \
    uuid-dev \
    ghostscript \
    ca-certificates-java \
    openssh-client \
    git \
    unzip

RUN apt-get install -y default-jdk-headless

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN useradd -ms /bin/bash nativescript

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip >> /tmp/sdkmanager.download.log
RUN unzip sdk-tools-linux-4333796.zip -d /opt/sdkmanager/ >> /tmp/sdkmanager.unzip.log

RUN echo 'export ANDROID_HOME=/opt/sdkmanager' >> /etc/profile
RUN echo 'export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin' >> /etc/profile

RUN touch /tmp/sdkmanager.log
RUN /bin/bash -c 'yes | sdkmanager --licenses >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "tools" "platform-tools" >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "extras;android;m2repository" >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "build-tools;22.0.1" "platforms;android-22" >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "build-tools;23.0.2" "platforms;android-23" >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "build-tools;26.0.3" "platforms;android-26" >> /tmp/sdkmanager.log'
RUN /bin/bash -c '( for i in $(seq 1 10); do sleep 5; echo y;  done ) | sdkmanager --install "build-tools;27.0.3" "platforms;android-27" >> /tmp/sdkmanager.log'

USER nativescript
WORKDIR /home/nativescript

USER root
