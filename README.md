# Kubernetes `net-expose`
Expose your Kubernetes resources to the world!

You have created a Kubernetes cluster at home with [k3sup](https://github.com/alexellis/k3sup), or you are using a [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) instance. You have created your `Pod`, your `Deployment` and `Service` and your are ready to publicly test it.

Exposing your deployment to the Internet is not so trivial though!

## What it does
Exposes internal Kubernetes resources (anything with an IP and port) to public VPS hosts.
You only need a working SSH key for the VPS. The rest is on `net-expose`



## How it works

![generic-schematic](https://github.com/operatorequals/k8s-net-expose/raw/documentation/assets/net-expose-schematic.png)