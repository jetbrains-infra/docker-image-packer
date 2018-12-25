FROM alpine:3.8

ARG PACKER_VERSION=1.3.3
ARG VSPHERE_VERSION=2.2
ARG TEAMCITY_VERSION=1.0

RUN apk update
RUN apk add ca-certificates wget
RUN update-ca-certificates
RUN wget -nv https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O packer.zip
RUN mkdir /out
RUN unzip packer.zip -d /out/
RUN wget -nv https://github.com/jetbrains-infra/packer-builder-vsphere/releases/download/v${VSPHERE_VERSION}/packer-builder-vsphere-iso.linux -O /out/packer-builder-vsphere-iso
RUN wget -nv https://github.com/jetbrains-infra/packer-builder-vsphere/releases/download/v${VSPHERE_VERSION}/packer-builder-vsphere-clone.linux -O /out/packer-builder-vsphere-clone
RUN wget -nv https://github.com/JetBrains/packer-post-processor-teamcity/releases/download/v${TEAMCITY_VERSION}/packer-post-processor-teamcity.linux -O /out/packer-post-processor-teamcity
RUN chmod +x /out/*

FROM alpine:3.8
COPY --from=0 /out/* /usr/local/bin/
ENTRYPOINT ["packer"]
