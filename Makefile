VERSION=0.1.0

CONN=ssh
REDIR=socat


docker:
	docker build . -t net-expose-$(CONN)-$(REDIR):$(VERSION) -f Dockerfile.$(CONN)-$(REDIR)