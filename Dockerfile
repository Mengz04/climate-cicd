# Use an official Node.js image with the desired version
FROM node:19.8.1

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

RUN npm run build

# Expose the port on which the application runs (if applicable)
EXPOSE 8080

# Command to run the application
CMD ["npm", "start"]
