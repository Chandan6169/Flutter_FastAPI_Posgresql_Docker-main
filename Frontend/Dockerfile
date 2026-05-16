# Use an Nginx image to serve the built app
FROM nginx:alpine

# Copy the Flutter web build output to the Nginx serving directory
COPY ./build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx and keep it running
CMD ["nginx", "-g", "daemon off;"]