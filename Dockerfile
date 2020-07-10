FROM alpine:3.12

ARG PACKER_VERSION=1.5.6
ARG TEAMCITY_VERSION=2.0

RUN apk update
RUN apk add ca-certificates wget
RUN update-ca-certificates
RUN wget -nv https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O packer.zip
RUN mkdir /out
RUN unzip packer.zip -d /out/
RUN wget -nv https://github.com/JetBrains/packer-post-processor-teamcity/releases/download/v${TEAMCITY_VERSION}/packer-post-processor-teamcity.linux -O /out/packer-post-processor-teamcity
RUN chmod +x /out/*

FROM alpine:3.12
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=0 /out/* /usr/local/bin/
ENTRYPOINT ["packer"]
