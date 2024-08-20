# Base debian image
ARG BASE_IMG=docker.io/debian/12.5-slim@sha256:67f3931ad8cb1967beec602d8c0506af1e37e8d73c2a0b38b181ec5d8560d395
FROM $BASE_IMG AS base

# apt dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    flatpak \
    flatpak-builder \
    gir1.2-gtk-3.0 \
    git \
    libcairo2-dev \
    libcanberra-gtk3-module \
    libgirepository1.0-dev \
    openjdk-17-jdk \
    pkg-config \
    python-is-python3 \
    python3 \
    python3-dev \
    python3-venv \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Work in /opt
WORKDIR /opt

# Java Development Kit 17
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Install beeware
RUN python3 -m venv venv ; \
    ./venv/bin/pip install briefcase ;
