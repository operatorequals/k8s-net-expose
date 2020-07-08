VERSION=0.1.0

CONN=ssh


docker:
# 	CONN_TAG="$(CONN)-"
# 	REDIR_TAG=$(REDIR)-
	docker build . -t operatorequals/k8s-net-expose:$(CONN)-$(VERSION) -f $(CONN)/Dockerfile


docker_push:
	docker push operatorequals/k8s-net-expose:$(CONN)-$(VERSION)