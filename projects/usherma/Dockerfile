FROM nginx:alpine

# Install development tools
RUN apk add --no-cache \
    git \
    openssh-client \
    nano \
    vim \
    curl \
    wget \
    bash \
    && rm -rf /var/cache/apk/*

# Set bash as default shell for better development experience
SHELL ["/bin/bash", "-c"]

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create a non-root user for development (optional)
RUN addgroup -g 1000 developer && \
    adduser -D -s /bin/bash -G developer -u 1000 developer

# Set working directory
WORKDIR /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
