# Grab official node image
FROM node:14.11.0-alpine3.10

# Install headless chrome
RUN apk update && apk add --no-cache nmap && \
  echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
  echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
  apk update && \
  apk add --no-cache \
  chromium \
  harfbuzz \
  "freetype>2.8" \
  ttf-freefont \
  nss

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV CHROMIUM_PATH=/usr/bin/chromium-browser

# Create working directory for node app
RUN mkdir -p /usr/src/app

# CD into working directory and copy package.json into it
WORKDIR /usr/src/app
COPY package.json package.json

# Install and clean cache
RUN npm install
# RUN npm install && npm cache clean

# Copy all files into working directory
COPY . .

# Start node app when container started
CMD [ "npm", "start" ]
