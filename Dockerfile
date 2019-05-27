FROM rust:1
LABEL maintainer="mike@thebarkers.com" \
      description="An exercism 'rust' track image." \
      version="0.1.2"

# Update, upgrade and install dev tools
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git procps tree vim wget

# Install exercism tool
RUN cd /tmp \
    && wget https://github.com/exercism/cli/releases/download/v3.0.11/exercism-linux-64bit.tgz \
    && tar xzf exercism-linux-64bit.tgz \
    && mv exercism /usr/local/bin/

# Set path for cargo and rust
ENV PATH="/usr/local/cargo/bin:/usr/local/rustup/bin:${PATH}"

# Update/setup rust
RUN rustup update
RUN rustup component add rls rust-analysis rust-src

# Install other dependencies
RUN apt-get install -y lldb-3.9

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Setup environment
RUN echo "PATH=$PATH" >> /root/.profile
ENV SHELL /bin/bash
WORKDIR /root/exercism

CMD ["bash", "--login"]
