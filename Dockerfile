FROM node:10.16-jessie

MAINTAINER blueapple1120@qq.com
# Use unicode
RUN locale-gen C.UTF-8 || true
ENV LANG=C.UTF-8

RUN apt-get update && \
    apt-get install -y  -q --no-install-recommends \
    mercurial xvfb \
    locales sudo openssh-client ca-certificates tar gzip parallel \
    net-tools netcat unzip zip bzip2 apt-transport-https build-essential libssl-dev \
    curl g++ gcc git make wget && rm -rf /var/lib/apt/lists/* && apt-get -y autoclean && \

# Set timezone to CST by default
    ln -sf /usr/share/zoneinfo/PRC /etc/localtime && \
# Install jq    
    JQ_URL=$(curl --location --fail --retry 3 https://api.github.com/repos/stedolan/jq/releases/latest  | grep browser_download_url | grep '/jq-linux64"' | grep -o -e 'https.*jq-linux64') && \
    curl --silent --show-error --location --fail --retry 3 --output /usr/bin/jq $JQ_URL && \
    chmod +x /usr/bin/jq
    
# Install other app
RUN npm i -g @webpack-contrib/tag-versions && \
    npm install && \
    npm -g install vuepress && \
    npm -g install node-sass
