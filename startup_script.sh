#!/bin/bash

# Adjust resource limits if needed
ulimit -n 65536
ulimit -u 4096

# Start Docker service (required for running Docker in Docker)
service docker start

# Wait for Docker daemon to be ready
until docker info >/dev/null 2>&1; do
    echo "Waiting for Docker daemon to start..."
    sleep 2
done

# Run a PostgreSQL container with default settings
docker run --name postgres -d postgres

# Keep the container running
tail -f /dev/null
