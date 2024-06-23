#!/bin/bash

# Start Docker service (required for running Docker in Docker)
service docker start

# Run a PostgreSQL container with default settings
docker run --name postgres -d postgres

# Keep the container running
tail -f /dev/null
