FROM alpine:3.6

ARG PACKER_VERSION=1.0.2

ARG VSPHERE_VERSION=1.3

RUN apk update && \
    apk add ca-certificates wget && \
    update-ca-certificates && \
    wget -nv https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O packer.zip && \
    unzip packer.zip -d /usr/local/bin/ && \
    rm packer.zip && \
    wget -nv https://github.com/jetbrains-infra/packer-builder-vsphere/releases/download/v${VSPHERE_VERSION}/packer-builder-vsphere.linux -O /usr/local/bin/packer-builder-vsphere && \
    chmod +x /usr/local/bin/packer-*

ENTRYPOINT ["packer"]
