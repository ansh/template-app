# You can use most Debian-based base images
FROM node:21-slim

# Install curl and unzip
RUN apt-get update && apt-get install -y curl unzip && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install dependencies and customize sandbox
WORKDIR /home/user/expo-app

# Create the app in a temporary directory
RUN npx create-expo-app@latest --template blank-typescript .

COPY package.json /home/user/expo-app/package.json
COPY bun.lock /home/user/expo-app/bun.lock
COPY package-lock.json /home/user/expo-app/package-lock.json
COPY app.json /home/user/expo-app/app.json

# Install dependencies
RUN npm ci

# Install @expo/ngrok globally for tunneling
RUN npm install -g @expo/ngrok@^4.1.0

# Move the Expo app to the home directory and remove the expo-app directory
RUN mv /home/user/expo-app/* /home/user/ && rm -rf /home/user/expo-app