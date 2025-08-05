FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        vim \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libffi-dev \
        liblzma-dev \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Python 3.11.0
RUN wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz && \
    tar xzf Python-3.11.0.tgz && \
    cd Python-3.11.0 && \
    ./configure --enable-optimizations && \
    make -j"$(nproc)" && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.11.0 Python-3.11.0.tgz

# Set Python 3.11 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.11 1

# Upgrade pip for Python 3.11
RUN /usr/local/bin/python3.11 -m pip install --upgrade pip

# Install TensorFlow CPU version
RUN /usr/local/bin/pip3.11 install tensorflow-cpu==2.12.0rc0

# Copy files into the container
COPY exploit.py /root/
COPY exec.py /root/
