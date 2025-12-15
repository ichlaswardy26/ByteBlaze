FROM node:18-alpine

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build the bot (JANGAN abaikan error)
RUN npm run build:full

# Buat semua direktori yang dibutuhkan dengan permission yang benar
RUN mkdir -p /app/logs /app/data && \
    chown -R node:node /app/logs /app/data

# Bersihkan cache untuk menghemat space
RUN npm cache clean --force

USER node

CMD ["npm", "start"]
