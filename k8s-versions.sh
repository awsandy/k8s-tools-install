echo "Cluster version"
kubectl version --short
echo "core dns 1.6.6+"
kubectl describe deployment coredns --namespace kube-system | grep Image | cut -d "/" -f 3
echo "cni 1.6.1+"
kubectl describe daemonset aws-node --namespace kube-system | grep Image | cut -d "/" -f 2
echo "KubeProxy 1.16.8+"
kubectl get daemonset kube-proxy --namespace kube-system -o=jsonpath='{$.spec.template.spec.containers[:1].image}'

