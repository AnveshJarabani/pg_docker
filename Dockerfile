# Use the official Python 3.11 base image
FROM python:3.11

# Install necessary dependencies to install Docker
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common


# Add Docker's official GPG key:
RUN apt-get update
RUN apt-get install ca-certificates curl
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update

# Install Docker Compose (optional)
RUN curl -L "https://github.com/docker/compose/releases/download/2.3.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

RUN \
    echo "ulimits: $(ulimit -Sn):$(ulimit -Hn)"; \
    sed -i 's/ulimit -Hn/# ulimit -Hn/g' /etc/init.d/docker; \
    service docker start; \
    rm -rf /var/cache/apt;

COPY requirements.txt .
# RUN pip install -r requirements.txt    
# Add a startup script
COPY startup_script.sh /usr/local/bin/startup_script.sh
RUN chmod +x /usr/local/bin/startup_script.sh

# startup_script on container run
CMD ["/usr/local/bin/startup_script.sh"]
