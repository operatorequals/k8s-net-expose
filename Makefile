VERSION=0.1.0

CONN=ssh
REDIR=socat


docker:
	docker build . -t operatorequals/k8s-net-expose:$(CONN)-$(REDIR)-$(VERSION) -f Dockerfile.$(CONN)-$(REDIR)


docker_push:
	docker push operatorequals/k8s-net-expose:$(CONN)-$(REDIR)-$(VERSION)