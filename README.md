# Kubernetes `net-expose`
Expose your Kubernetes resources to the world!

You have created a Kubernetes cluster at home with [k3sup](https://github.com/alexellis/k3sup), or you are using a [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) instance. You have created your `Pod`, your `Deployment` or `Service` and your are ready to publicly test it.

Exposing your deployment to the Internet is not so trivial though!

## How to install
To install `net-expose` through Helm you need to add this git repository as a helm repo:
```bash
helm repo add net-expose https://raw.githubusercontent.com/operatorequals/k8s-net-expose/master/charts/stable
helm repo update

helm install nginx-ingress net-expose/net-expose \
	--set ssh.host=ssh-connect.example.com \
	--set ssh.user=admin \
	--set-file ssh.key=~/.ssh/id_rsa \
	--set remotePort=8080 \
	--set k8sExportService.name=nginx-ingress-controller \
	--set k8sExportService.port=80
```


## What it does
Exposes internal Kubernetes resources (anything with an IP and port) to public VPS hosts.
You only need a working SSH key for the VPS. The rest is on `net-expose`.

![generic-schematic](https://github.com/operatorequals/k8s-net-expose/raw/documentation/assets/net-expose-schematic.png)

## How it works

The `net-expose` deployment consists of a Kubernetes `Pod` with just enough privileges to remotely SSH to a VPS and establish a 
reverse SSH proxy, redirecting VPS port traffic to the internal Kubernetes resource (`Pod` or `Service`) to be exposed,
making it accessible through the initial VPS port.

![generic-schematic-deep](https://github.com/operatorequals/k8s-net-expose/raw/documentation/assets/net-expose-schematic-deep.png)


### The SSH server catch of `GatewayPorts` option

OpenSSH server does not allow reverse tunnels to expose ports to all interfaces by default (only to `localhost`). To enable this
the `GatewayPorts` has to be set to `yes` in the `/etc/ssh/sshd_config` as below:
```
[...]
GatewayPorts yes
[...]
```

 To automate this process the `gatewayports_test.sh` can be used as below:
```bash
 ssh -i id_rsa REMOTE_HOST -l root ' sudo sh -s '  < gatewayports_test.sh
 ```

 To apply the change the SSH server needs a restart.

#### The `gatewayports` `initContainer`

A K8s `initContainer` can be created from the Helm release to automatically run the `gatewayports_test.sh` towards the remote
host and restart the SSH server before creating the connection tunnel.
To enable this feature the `gatewayports.enable` needs to be set to `true` in the Helm `values.yaml` as below:

```bash
helm install nginx-ingress net-expose/net-expose \
[...]
	--set gatewayports.enable=true
```
