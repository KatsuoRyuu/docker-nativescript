FROM runmymind/docker-android-sdk:ubuntu-standalone

RUN apt-get update
RUN apt-get install -y --no-install-recommends nodejs npm
RUN npm install -g nativescript --unsafe-perm
RUN npm install nativescript --unsafe-perm
RUN $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools" "platforms;android-26" "build-tools;26.0.2" "extras;android;m2repository" "extras;google;m2repository" > /dev/null
RUN npm i