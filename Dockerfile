FROM node:18-alpine

WORKDIR /app

# Salin package.json terlebih dahulu
COPY package*.json ./

# Install versi spesifik dependency
RUN npm install discord.js@14.11.0 @discordjs/voice@0.16.0 @discordjs/builders@1.6.3

# Install dependensi lainnya
RUN npm install

# Copy semua file
COPY . .

# Build bot
RUN npm run build:full

# Buat direktori yang dibutuhkan
RUN mkdir -p /app/logs /app/data && \
    chown -R node:node /app/logs /app/data

USER node

CMD ["npm", "start"]
