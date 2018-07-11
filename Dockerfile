FROM alpine:3.8

MAINTAINER Christian Hoffmeister <mail@choffmeister.de>

ENV KUBECTL_VERSION="1.10.5"
ENV HELM_VERSION="2.9.1"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -sL https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && curl -sL https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o /tmp/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
 && cd /tmp \
 && tar xfvz helm-v${HELM_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin/helm \
 && chmod +x /usr/local/bin/helm \
 && rm -r linux-amd64/ \
 && rm helm-v${HELM_VERSION}-linux-amd64.tar.gz \
 && apk del --purge deps \
 && rm /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["version"]
