FROM jenkins/jenkins:2.176.3

MAINTAINER Chad Gilbert <chad.gilbert@cqlcorp.com>

USER root

# RUN apt-get update && apt-get install -y git-lfs && rm -rf /var/lib/apt/lists/*

# Taken from the recommended debian docker install section from
# https://github.com/git-lfs/git-lfs/wiki/Installation
RUN build_deps="curl" && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ${build_deps} ca-certificates && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git-lfs && \
    git lfs install && \
    DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove ${build_deps} && \
    rm -r /var/lib/apt/lists/*

USER jenkins

