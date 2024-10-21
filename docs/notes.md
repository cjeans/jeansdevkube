# Copying secrets

Example :

```
kubectl get secret gitlab-registry --namespace=revsys-com --export -o yaml |\
   kubectl apply --namespace=devspectrum-dev -f -
```

## Output of install-all.sh

bash -i install-all.sh
Hit:1 http://archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://security.ubuntu.com/ubuntu noble-security InRelease
Get:3 http://archive.ubuntu.com/ubuntu noble-updates InRelease [126 kB]
Hit:4 http://archive.ubuntu.com/ubuntu noble-backports InRelease
Fetched 126 kB in 3s (42.8 kB/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
10 packages can be upgraded. Run 'apt list --upgradable' to see them.
Waiting for Microk8s ready state
microk8s is running
high-availability: no
datastore master nodes: 127.0.0.1:19001
datastore standby nodes: none
addons:
enabled:
dns # (core) CoreDNS
ha-cluster # (core) Configure high availability on the current node
helm # (core) Helm - the package manager for Kubernetes
helm3 # (core) Helm 3 - the package manager for Kubernetes
metallb # (core) Loadbalancer for your Kubernetes cluster
rbac # (core) Role-Based Access Control for authorisation
disabled:
cert-manager # (core) Cloud native certificate management
cis-hardening # (core) Apply CIS K8s hardening
community # (core) The community addons repository
dashboard # (core) The Kubernetes dashboard
gpu # (core) Alias to nvidia add-on
host-access # (core) Allow Pods connecting to Host services smoothly
hostpath-storage # (core) Storage class; allocates storage from host directory
ingress # (core) Ingress controller for external access
kube-ovn # (core) An advanced network fabric for Kubernetes
mayastor # (core) OpenEBS MayaStor
metrics-server # (core) K8s Metrics Server for API access to service metrics
minio # (core) MinIO object storage
nvidia # (core) NVIDIA hardware (GPU and network) support
observability # (core) A lightweight observability stack for logs, traces and metrics
prometheus # (core) Prometheus operator for monitoring and logging
registry # (core) Private image registry exposed on localhost:32000
rook-ceph # (core) Distributed Ceph storage using Rook
storage # (core) Alias to hostpath-storage add-on, deprecated
Client Version: v1.30.5
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.30.5
Infer repository core for addon rbac
Addon core/rbac is already enabled
Infer repository core for addon metallb
Addon core/metallb is already enabled
"halkeye" already exists with the same configuration, skipping
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "halkeye" chart repository
Update Complete. ⎈Happy Helming!⎈
Install who-am-i demo application
namespace/whoami created
NAME: whoami
LAST DEPLOYED: Sun Oct 20 17:28:11 2024
NAMESPACE: whoami
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:

1. Get the application URL by running these commands:
   export POD_NAME=$(kubectl get pods --namespace whoami -l "app=whoami,release=whoami" -o jsonpath="{.items[0].metadata.name}")
   export POD_NAME=$(kubectl get pods --namespace whoami -o jsonpath="{.items[0].metadata.name}")
   echo "Visit http://127.0.0.1:8080 to use your application"
   kubectl port-forward $POD_NAME 8080:80
   deployment.apps/whoami scaled
   The Ingress "ingress-whoami" is invalid: spec.rules[0].host: Invalid value: "whoami.": a lowercase RFC 1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character (e.g. 'example.com', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)\*')
   Installation done who-am-i demo application
   Install ingress web server
   namespace/ingress-nginx created
   NAME: nginx-helm
   LAST DEPLOYED: Sun Oct 20 17:28:23 2024
   NAMESPACE: ingress-nginx
   STATUS: deployed
   REVISION: 1
   TEST SUITE: None
   NOTES:
   The ingress-nginx controller has been installed.
   It may take a few minutes for the load balancer IP to be available.
   You can watch the status by running 'kubectl get service --namespace ingress-nginx nginx-helm-ingress-nginx-controller --output wide --watch'

An example Ingress that makes use of the controller:
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
name: example
namespace: foo
spec:
ingressClassName: nginx
rules: - host: www.example.com
http:
paths: - pathType: Prefix
backend:
service:
name: exampleService
port:
number: 80
path: / # This section is only required if TLS is to be enabled for the Ingress
tls: - hosts: - www.example.com
secretName: example-tls

If TLS is enabled for the Ingress, a Secret containing the certificate and key must also be provided:

apiVersion: v1
kind: Secret
metadata:
name: example-tls
namespace: foo
data:
tls.crt: <base64 encoded cert>
tls.key: <base64 encoded key>
type: kubernetes.io/tls
Installation done ingress
Install kubernetes dashboard
Release "kubernetes-dashboard" does not exist. Installing it now.
NAME: kubernetes-dashboard
LAST DEPLOYED: Sun Oct 20 17:28:48 2024
NAMESPACE: kubernetes-dashboard
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:

---

**_ PLEASE BE PATIENT: Kubernetes Dashboard may need a few minutes to get up and become ready _**

---

Congratulations! You have just installed Kubernetes Dashboard in your cluster.

To access Dashboard run:
kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443

NOTE: In case port-forward command does not work, make sure that kong service name is correct.
Check the services in Kubernetes Dashboard namespace using:
kubectl -n kubernetes-dashboard get svc

Dashboard will be available at:
https://localhost:8443
serviceaccount/simple-user created
clusterrolebinding.rbac.authorization.k8s.io/simple-user unchanged
The Ingress "ingress-dashboard-service" is invalid: spec.rules[0].host: Invalid value: "dashboard.": a lowercase RFC 1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character (e.g. 'example.com', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)\*')
Installation done dashboard
Error from server (NotFound): namespaces "nfs-storage" not found
Install nfs service (client needs existing server)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
nfs-common is already the newest version (1:2.6.4-3ubuntu5).
0 upgraded, 0 newly installed, 0 to remove and 10 not upgraded.
"nfs-subdir-external-provisioner" already exists with the same configuration, skipping
namespace/nfs-storage created
Error: INSTALLATION FAILED: cannot patch "pv-nfs-client-nfs-subdir-external-provisioner" with kind PersistentVolume: PersistentVolume "pv-nfs-client-nfs-subdir-external-provisioner" is invalid: [spec.nfs.server: Required value, spec.nfs.path: Required value, spec.nfs.path: Invalid value: "": must be an absolute path, spec.persistentvolumesource: Forbidden: spec.persistentvolumesource is immutable after creation
  core.PersistentVolumeSource{
   ... // 2 identical fields
   HostPath: nil,
   Glusterfs: nil,
   NFS: &core.NFSVolumeSource{
-  Server: "url_of_your_nfs_server",
+  Server: "",
-  Path: "/Public/nfs/kubedata",
+  Path: "",
   ReadOnly: false,
   },
   RBD: nil,
   Quobyte: nil,
   ... // 15 identical fields
  }
]
Installation done nfs client
Install prometheus
namespace/prometheus created
persistentvolumeclaim/prometheus-pvc created
The PersistentVolume "prometheus-pv" is invalid:

- spec.nfs.server: Required value
- spec.nfs.path: Required value
- spec.nfs.path: Invalid value: "": must be an absolute path
  NAME: prometheus
  LAST DEPLOYED: Sun Oct 20 17:29:24 2024
  NAMESPACE: prometheus
  STATUS: deployed
  REVISION: 1
  TEST SUITE: None
  NOTES:
  The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
  prometheus-server.prometheus.svc.cluster.local

Get the Prometheus server URL by running these commands in the same shell:
export POD_NAME=$(kubectl get pods --namespace prometheus -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace prometheus port-forward $POD_NAME 9090

#################################################################################

###### WARNING: Pod Security Policy has been disabled by default since

###### it deprecated after k8s 1.25+. use

###### (index .Values "prometheus-node-exporter" "rbac"

###### . "pspEnabled") with (index .Values

###### "prometheus-node-exporter" "rbac" "pspAnnotations")

###### in case you still need it.

#################################################################################

The Prometheus PushGateway can be accessed via port 9091 on the following DNS name from within your cluster:
prometheus-prometheus-pushgateway.prometheus.svc.cluster.local

Get the PushGateway URL by running these commands in the same shell:
export POD_NAME=$(kubectl get pods --namespace prometheus -l "app=prometheus-pushgateway,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace prometheus port-forward $POD_NAME 9091

For more information on running Prometheus, visit:
https://prometheus.io/
Installation done prometheus
The Ingress "ingress-prometheus" is invalid: spec.rules[0].host: Invalid value: "prometheus.": a lowercase RFC 1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character (e.g. 'example.com', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)\*')
Installation done prometheus
Install grafana
namespace/grafana created
persistentvolumeclaim/grafana-pvc created
The PersistentVolume "grafana-pv" is invalid:

- spec.nfs.server: Required value
- spec.nfs.path: Required value
- spec.nfs.path: Invalid value: "": must be an absolute path
  secret/grafana-creds created
  NAME: grafana
  LAST DEPLOYED: Sun Oct 20 17:29:40 2024
  NAMESPACE: grafana
  STATUS: deployed
  REVISION: 1
  NOTES:

1. Get your 'admin' user password by running:

   kubectl get secret --namespace grafana grafana-creds -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

2. The Grafana server can be accessed via port 80 on the following DNS name from within your cluster:

   grafana.grafana.svc.cluster.local

   Get the Grafana URL to visit by running these commands in the same shell:
   export POD_NAME=$(kubectl get pods --namespace grafana -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
   kubectl --namespace grafana port-forward $POD_NAME 3000

3. Login with the password from step 1 and the username: admin
   The Ingress "ingress-grafana" is invalid: spec.rules[0].host: Invalid value: "grafana.": a lowercase RFC 1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character (e.g. 'example.com', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)\*')
   Installation done grafana
   Next steps: Installation of cert-manager
   Cert manager automates creation and renewal of LetsEncrypt certificates
   Follow docs/cert-manager.md
   root@kmaster:~/jeansdevkube/src#
   Get the Grafana URL to visit by running these commands in the same shell:
   export POD_NAME=$(kubectl get pods --namespace grafana -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
   kubectl --namespace grafana port-forward $POD_NAME 3000

4. Login with the password from step 1 and the username: admin
   The Ingress "ingress-grafana" is invalid: spec.rules[0].host: Invalid value: "grafana.": a lowercase RFC 1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character (e.g. 'example.com', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)\*')
   Installation done grafana
   Next steps: Installation of cert-manager
   Cert manager automates creation and renewal of LetsEncrypt certificates
