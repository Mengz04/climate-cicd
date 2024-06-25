# Build stage
FROM node:19.8.1-alpine AS build

# Set working directory
WORKDIR /app

# Copy all files to working directory
COPY . .

# Install dependencies
RUN npm install

# Build React app
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built files from build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
