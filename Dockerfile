FROM alpine:3.6

ARG PACKER_VERSION=1.0.4

ARG VSPHERE_VERSION=1.4
ARG TEAMCITY_VERSION=0.1

RUN apk update && \
    apk add ca-certificates wget && \
    update-ca-certificates && \
    wget -nv https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O packer.zip && \
    unzip packer.zip -d /usr/local/bin/ && \
    rm packer.zip && \
    wget -nv https://github.com/jetbrains-infra/packer-builder-vsphere/releases/download/v${VSPHERE_VERSION}/packer-builder-vsphere.linux -O /usr/local/bin/packer-builder-vsphere && \
    wget -nv https://github.com/JetBrains/packer-post-processor-teamcity/releases/download/v${TEAMCITY_VERSION}/packer-post-processor-teamcity.linux -O /usr/local/bin/packer-post-processor-teamcity && \
    chmod +x /usr/local/bin/packer-*

ENTRYPOINT ["packer"]
