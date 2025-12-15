# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build:full

# Runtime stage
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY --from=builder /app/dist ./dist

RUN mkdir -p /app/data /app/logs && \
    chown -R node:node /app/data /app/logs && \
    chmod -R 775 /app/data /app/logs

USER node
CMD ["npm", "start"]
