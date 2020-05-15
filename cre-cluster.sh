export AWS_REGION=eu-west-2
time eksctl create cluster -f cluster-nodes.yaml
kubectl get nodes
#eksctl utils update-cluster-logging --enable-types all --cluster ateks1 --approve
