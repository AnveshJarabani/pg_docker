#!/bin/bash


# Start Docker service (required for running Docker in Docker)
service docker start

# Wait for Docker daemon to be ready
until docker info >/dev/null 2>&1; do
    echo "Waiting for Docker daemon to start..."
    sleep 2
done

# Run a PostgreSQL container with default settings
docker run --name postgres -d -e POSTGRES_PASSWORD=gholymolyl postgres

# Keep the container running
tail -f /dev/null
