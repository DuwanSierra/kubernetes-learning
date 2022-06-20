FROM bitnami/kubectl as kubectl
FROM alpine/helm as heml
FROM jenkins/inbound-agent
# COPY BINARIES
USER root
RUN apt-get update && apt-get install -y gettext-base
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/
COPY --from=heml /usr/bin/helm /usr/bin/helm