# Kubernetes `net-expose`
Expose your Kubernetes resources to the world!

You have created a Kubernetes cluster at home with [k3sup](https://github.com/alexellis/k3sup), or you are using a [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) instance. You have created your `Pod`, your `Deployment` or `Service` and your are ready to publicly test it.

Exposing your deployment to the Internet is not so trivial though!

## What it does
Exposes internal Kubernetes resources (anything with an IP and port) to public VPS hosts.
You only need a working SSH key for the VPS. The rest is on `net-expose`.

![generic-schematic](https://github.com/operatorequals/k8s-net-expose/raw/documentation/assets/net-expose-schematic.png)

## How it works

The `net-expose` deployment consists of a Kubernetes `Pod` with just enough privileges to remotely SSH to a VPS and establish a 
reverse SSH proxy, redirecting VPS port traffic inside the `Pod`. A redirector (`socat`) in the `Pod` addresses the TCP connections to the 
internal Kubernetes resource (`Pod` or `Service`) to be exposed, making it accessible through the initial VPS port.

![generic-schematic-deep](https://github.com/operatorequals/k8s-net-expose/raw/documentation/assets/net-expose-schematic-deep.png)


### The SSH server catch of `GatewayPorts` option

OpenSSH server does not allow reverse tunnels to expose ports to all interfaces by default (only to `localhost`). To enable this
the `GatewayPorts` has to be set to `yes` in the `/etc/ssh/sshd_config` as below:
```
[...]
GatewayPorts yes
[...]
```
