FROM node:16.16.0
WORKDIR /app
COPY package*.json ./
RUN npm install -g npm@8.16.0
RUN npm install
COPY . .
EXPOSE 8080
CMD ["node", "server.js"]
