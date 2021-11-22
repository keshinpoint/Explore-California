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

create_kind_cluster: install_kind install_kubectl create_dockerfile_registry
	./kind create cluster --name explorecalifornia.com --config ./kind_config.yaml || true   && \
		kubectl get nodes

create_dockerfile_registry:
	if docker ps | grep -q 'local-registry'; \
	then echo "--> local registry already exists, hence we'll skip this step. Keshav wrote this as part of the Makefile recipe"; \
	else docker run --name local-registry -d --restart=always -p 5000:5000 registry:2; \
	fi

connect_registry_to_kind_network:
	docker network connect kind local-registry || true

connect_registry_to_kind: connect_registry_to_kind_network
	kubectl apply -f ./kind_configmap.yaml

create_kind_cluster_with_registry:
	$(MAKE) create_kind_cluster && $(MAKE) connect_registry_to_kind

delete_kind_cluster_cali:
	./kind delete cluster --name explorecalifornia.com 

delete_dockerfile_registry:
	if docker ps | grep -q 'local-registry'; \
	then docker stop local-registry && docker rm local-registry; \
	fi
