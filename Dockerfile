FROM debian:9
LABEL maintainer="mike@thebarkers.com" \
      description="An exercism 'rust' track image." \
      version="0.1.1"

# Update, upgrade and install dev tools
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git procps tree vim wget 

# Install exercism tool
RUN cd /tmp \
    && wget https://github.com/exercism/cli/releases/download/v3.0.11/exercism-linux-64bit.tgz \
    && tar xzf exercism-linux-64bit.tgz \
    && mv exercism /usr/local/bin/

# Install rust
RUN apt-get update \
    && apt-get install -y curl build-essential \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y

WORKDIR /root/exercism

CMD ["bash", "--login"]
