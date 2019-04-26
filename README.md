# helm-continuous

Docker image with kubectl and helm for simple continuous deployment/delivery.

```
# create a service account with cluster-admin role
kubectl create serviceaccount deployer
kubectl create clusterrolebinding deployer-cluster-rule --clusterrole=cluster-admin --serviceaccount=default:deployer

# get bearer token
export BEARER_TOKEN=$(kubectl get secret $(kubectl get serviceaccount deployer -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 -d)

# get cluster certificate authority (as base64)
export CERTIFICATE_AUTHORITY=$(kubectl get secret $(kubectl get serviceaccount deployer -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.ca\.crt}")

docker run --rm -it \
    -e SERVER=https://1.2.3.4:6443 \
    -e CERTIFICATE_AUTHORITY=${CERTIFICATE_AUTHORITY} \
    -e BEARER_TOKEN=${BEARER_TOKEN} \
    choffmeister/helm-continuous:latest \
    ls
```
