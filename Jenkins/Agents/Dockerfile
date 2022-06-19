FROM bitnami/kubectl as kubectl
FROM alpine/helm as heml
FROM jenkins/inbound-agent
# COPY BINARIES
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/
COPY --from=heml /usr/bin/helm /usr/bin/helm