FROM node:18-alpine

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build the bot dengan command yang benar
RUN npm run build:full

# Create config directory
RUN mkdir -p /app/config

# Use non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S botuser -u 1001 && \
    chown -R botuser:nodejs /app
USER botuser

CMD ["npm", "start"]
