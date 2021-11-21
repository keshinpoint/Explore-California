.PHONY: run_website stop_website install_kind create_kind_cluster

run_website:
	docker build -t explorecalifornia.com . && \
		docker run --rm --name Keshav -p 2000:80 explorecalifornia.com

stop_website:
		docker stop Keshav

install_kind:
	curl --location --output ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.11.1/kind-darwin-arm64 && \
		./kind --version

install_kubectl:
	brew install kubectl

create_kind_cluster: install_kind install_kubectl
	./kind create cluster --name explorecalifornia.com && \
		kubectl get nodes
