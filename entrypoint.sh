#!/bin/sh -e

mkdir -p "${HOME}/.kube"
echo ${CERTIFICATE_AUTHORITY} | base64 -d > "${HOME}/.kube/certificate-authority.crt"
kubectl config set-cluster cluster --server=${SERVER} --certificate-authority="${HOME}/.kube/certificate-authority.crt" >/dev/null
kubectl config set-credentials user --token=${BEARER_TOKEN} >/dev/null
kubectl config set-context context --cluster=cluster --user=user >/dev/null
kubectl config use-context context >/dev/null

helm init --client-only >/dev/null
helm $@
