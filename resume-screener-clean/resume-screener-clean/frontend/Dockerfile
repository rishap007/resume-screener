FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Use npm install instead of npm ci (handles sync issues automatically)
RUN npm install

# Copy source code
COPY . .

# Set environment for Docker hot reloading
ENV CHOKIDAR_USEPOLLING=true

EXPOSE 3000

CMD ["npm", "start"]
