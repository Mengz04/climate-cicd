# Stage 1: Build the React app
FROM node:14-alpine as build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm cache clean --force && npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the React app with Nginx
FROM nginx:alpine

# Copy build files from the previous stage
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# Add the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Default command to run Nginx (no need to specify CMD as nginx image has default CMD)
