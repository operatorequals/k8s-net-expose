# net-expose

Expose your Kubernetes resources to the world!

## TL;DR;

```console
$ helm install net-expose
```

## Introduction

This chart bootstraps an `net-expose` deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name my-release net-expose/
```

The command deploys net-expose on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the net-expose chart and their default values.

Parameter | Description | Default
--- | --- | ---
`image` | | `operatorequals/k8s-net-expose`
`ssh.host` | The remote host to connect through SSH | `""`
`ssh.user` | The remote SSH port | 22
`ssh.user` | The SSH user to connect too | root
`ssh.key`  | The SSH key filepath. It needs to be set with `--set-file` | `/path/to/id_rsa`
`remotePort` | The port that listens for connections on the remote host. To bind ports `<1024` the `ssh.user` needs to have `root` privileges in the remote host | `8000`
`k8sExportService.name` | The Kubernetes `Service` or `Pod` hostname or DNS | `kubernetes-dashboard`
`k8sExportService.port` | The Kubernetes `Service` or `Pod` port that needs to be exposed | `80`
`podInternal.port` | The `net-expose` Pod port that redirects traffic. | `9999`


These parameters can be passed via Helm's `--set` option
```console
$ helm install --replace ec2-instance1 net-expose \
	--set ssh.host=x.x.x.x \
	--set ssh.user=ec2-user \
	--set-file ssh.key=.ssh/id_rsa \
	--set k8sExportService.name=nginx-ingress-controller \
	--set k8sExportService.port=443 \
	--set remotePort=443

```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install net-expose --name my-release -f values.yaml
```
