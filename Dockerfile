FROM node:18-alpine

WORKDIR /app

# Salin package files
COPY package*.json ./

# Install SEMUA dependensi sekaligus (jangan pecah)
RUN npm install

# Copy source code
COPY . .

# Build bot
RUN npm run build:full

# Buat direktori yang dibutuhkan
RUN mkdir -p /app/logs /app/data && \
    chown -R node:node /app/logs /app/data

USER node

CMD ["npm", "start"]
