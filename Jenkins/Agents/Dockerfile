FROM bitnami/kubectl as kubectl
FROM jenkins/inbound-agent

# Do whatever you need to with the
# ubuntu-or-whatever-image:tag image, then:

COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/