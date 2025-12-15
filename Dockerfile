FROM node:18-alpine

WORKDIR /app

# Copy package files dan install SEMUA dependencies (termasuk dev)
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build bot (membutuhkan tsc → butuh devDependencies)
RUN npm run build:full

# Opsional: Install ulang hanya production dependencies untuk mengurangi ukuran final image
RUN npm install --only=production

# Buat folder config
RUN mkdir -p /app/config

# Gunakan user non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S botuser -u 1001 && \
    chown -R botuser:nodejs /app
USER botuser

CMD ["npm", "start"]
