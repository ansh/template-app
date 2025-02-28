# You can use most Debian-based base images
FROM node:21-slim

# Install curl
RUN apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install bun
RUN curl -fsSL https://bun.sh/install | bash

# Install dependencies and customize sandbox
WORKDIR /home/user/expo-app

RUN npx create-expo-app@latest --template blank-typescript
COPY package.json /home/user/expo-app/package.json
COPY bun.lock /home/user/expo-app/bun.lock
COPY app.json /home/user/expo-app/app.json

RUN bun install

# Move the Expo app to the home directory and remove the expo-app directory
RUN mv /home/user/expo-app/* /home/user/ && rm -rf /home/user/expo-app