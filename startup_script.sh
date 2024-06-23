#!/bin/bash

# Adjust resource limits if needed
# Modify ulimit setting in /etc/init.d/docker
echo "Modifying ulimit setting in /etc/init.d/docker..."
sed -i 's/ulimit -Hn 524288/ulimit -n 524288/' /etc/init.d/docker

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
