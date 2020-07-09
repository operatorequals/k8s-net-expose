VERSION=0.1.0

CONN=ssh


docker:
	docker build . -t operatorequals/k8s-net-expose:$(CONN)-$(VERSION) -f $(CONN)/Dockerfile

docker_push:
	docker push operatorequals/k8s-net-expose:$(CONN)-$(VERSION)

helm_develop:
	find charts/develop/ -type d -exec helm package {} --destination charts/develop \;
	helm repo index charts/develop/

helm_stable:
	cp -r charts/develop/* charts/stable
