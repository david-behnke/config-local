cluster:
	curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
	k3d cluster create --config cluster/k3d.yaml

argocd:
	kubectl config set current-context k3d-k3s-default
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	kubectl apply -f deployments/argocd-ingress/ingress.yaml

argocd-secret:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

argo-cli:
	curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
	chmod +x /usr/local/bin/argocd

crossplane:
	kubectl apply -f apps/crossplane.yaml


.PHONY: cluster