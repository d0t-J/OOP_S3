FROM ubuntu:focal

# Set environment variables
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk
ENV FLUTTER_SDK_ROOT=/usr/lib/flutter
ENV FLUTTER_SDK_VERSION=3.27.1-stable

# Include flutter and android tools in PATH
ENV PATH="${PATH}:${FLUTTER_SDK_ROOT}/bin:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools"

# Enable noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies and essential development tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    build-essential \          # Basic compilation tools
    clang \                    # C/C++ compiler
    cmake \                    # Build configuration tool
    ninja-build \              # Fast build tool
    libgtk-3-dev \             # GTK for Linux desktop support
    watchman \
    openjdk-17-jdk \
    android-sdk \
    wget \
    unzip \
    zip \
    curl \
    git-all \
    xz-utils \
    libglu1-mesa \
    libc6:amd64 libstdc++6:amd64 lib32z1 libbz2-1.0:amd64 && \
    rm -rf /var/lib/apt/lists/*

# Add flutter to safe directory in git
RUN git config --global --add safe.directory /usr/lib/flutter

# Configure git user details
RUN git config --global user.name "Your Name" \
    && git config --global user.email "mail@example.com"

# Download and install Android Command Line Tools
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    wget -O commandlinetools.zip "https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip" && \
    unzip commandlinetools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools && \
    mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest && \
    rm commandlinetools.zip

# Accept Android SDK licenses and install necessary components
RUN yes | ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --licenses && \
    ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-34" "build-tools;33.0.0"

# Install Flutter SDK
RUN mkdir -p ${FLUTTER_SDK_ROOT} && \
    cd ${FLUTTER_SDK_ROOT} && \
    curl -OL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_SDK_VERSION}.tar.xz && \
    tar -xf flutter_linux_${FLUTTER_SDK_VERSION}.tar.xz -C /usr/lib/ && \
    rm -rf flutter_linux_${FLUTTER_SDK_VERSION}.tar.xz

# Disable Flutter telemetry
RUN flutter --disable-analytics

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]
