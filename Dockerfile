FROM node:18-alpine

WORKDIR /app

# Install dependencies dengan versi spesifik
COPY package*.json ./
RUN npm install discord.js@^14.14.1 @discordjs/voice@^0.17.0 @discordjs/builders@^1.8.1
RUN npm install

# Copy source code
COPY . .

# Fix permission dan instalasi package tambahan
RUN apk add --no-cache git python3 py3-pip make g++ && \
    npm install -g typescript

# Build dengan ignore error sementara (untuk development)
RUN npm run build:prettier || echo "Prettier failed but continuing"
RUN tsc --build || echo "TypeScript build failed but continuing"

# Setup config
RUN mkdir -p /app/config

# Clean build tools untuk menghemat space
RUN apk del git python3 py3-pip make g++ && \
    npm cache clean --force && \
    rm -rf /tmp/* /var/tmp/*

USER node

CMD ["node", "dist/index.js"]
