FROM node:20-alpine
‎
‎WORKDIR /app
‎
‎# Install dependencies
‎COPY package*.json ./
‎RUN npm install
‎
‎# Copy source code
‎COPY . .
‎
‎# Build bot
‎RUN npm run build:full
‎
‎# Fix permission untuk direktori data
‎RUN mkdir -p /app/data /app/logs && \
‎    chown -R node:node /app/data /app/logs && \
‎    chmod -R 775 /app/data /app/logs
‎
‎USER node
‎
‎CMD ["npm", "start"]
