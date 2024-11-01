# Ingress and MetalLb

Ingress is a very useful component for having a common entrypoint for multiple services.
We will use ![](images/ico/color/homekube_16.png)[ Ingress](microk8s-addons.md#ingress)
together with [![](images/ico/book_16.png) MetalLb](https://metallb.universe.tf)
which serves as a replacement for cloud-based LoadBalancers. In a typical cloud environment all incoming
traffic will flow into a kubernetes cluster from the LoadBalancer and MetalLb is a compatible
replacement for non-cloud installations.

Data flow will be

```
                             Nginx      Dashboard
Internet -> LoadBalancer ->  Ingress -> service
```

## Preparation

```bash
cd ~/homekube/src/ingress
```

A `pwd` should now show something like `/home/mykube/k8s/ingress`.  
Make sure you have installed ![](images/ico/color/homekube_16.png)[ Helm](helm.md) before you proceed.

## Installation

We will setup own namespaces for metallb and ingress-nginx to allow an easier maintenance later.
Microk8s default installation tends to install many add-ons in the 'kube-system' namespace.
That makes it harder later if it turns out that the default installation needs to be modified or extended.

```bash
kubectl create namespace metallb-system
kubectl apply -f metallb-config.yaml
helm install metallb --version=0.12.0 -n metallb-system stable/metallb
```

These commands are a helm based replacements for microk8s LoadBalancer enablement `microk8s enable metallb`.
If you need to reconfigure the default portrange `192.168.1.200-192.168.1.201` please
edit `metallb-config.yaml` to match your environment.

Next we'll install ingress-nginx. The notable difference to `microk8s enable ingress` is that this configuration
prepares ingress for later usage of scraping metrics and provide some traffic visualisation.
That wasn't easy to extend when using microk8s version.

```bash
kubectl create namespace ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install nginx-helm -n ingress-nginx --version=4.0.6 \
  -f ingress-helm-values.yaml \
  ingress-nginx/ingress-nginx
```

## Configuration

Next we configure the dashboard service. If you have already configured Apache2 or Nginx reverse proxies
this may be a bit familiar for you. The manifest type is `Ingress` and
the noticeable difference is that configuration is done through annotations.
Read more about
[![](images/ico/color/kubernetes_16.png) Ingress configuration](https://kubernetes.io/docs/concepts/services-networking/ingress/).  
There is a long list of
[![](images/ico/color/kubernetes_16.png) available annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/).
Reference of
[![](images/ico/book_16.png) embedded variables](http://nginx.org/en/docs/http/ngx_http_core_module.html#variables)

We accept https incoming traffic, then unwrap it and wrap it again in https to forward it to the kubernetes dashboard.
It is an important detail that the **Ingress manifest must be defined in the same namespace as the service it references**
e.g. `namespace: kubernetes-dashboard` .

```bash
cd ~/homekube/src/dashboard
kubectl apply -f ingress-dashboard.yaml
```

In your **local browser open `https://192.168.1.200`**  
Dashboard now opens via Ingress in addition to the previous configuration.

![](images/dashboard-signin.png)

Note that we did not provide a certificate so far.
Ingress will present your browser a `Kubernetes Ingress controller Fake Certificate`
certificate that is different from the one presented by the dashboard service and
the default dashboard certificate. Although Chrome again shows the `NET::ERR_CERT_AUTHORITY_INVALID`
error it will now show a `Proceed to 192.168.1.200 (unsafe)` option.

## CJ Route traffic to the k8s cluster

```
# Flush existing rules
sudo iptables -F

# Allow traffic from the main network to the cluster network
sudo iptables -A FORWARD -s 192.168.254.0/24 -d 10.1.189.0/24 -j ACCEPT

# Allow traffic from the cluster network to the main network
sudo iptables -A FORWARD -s 10.1.189.0/24 -d 192.168.254.0/24 -j ACCEPT

# Enable NAT for traffic from the main network to the cluster network
sudo iptables -t nat -A POSTROUTING -s 192.168.254.0/24 -d 10.1.189.0/24 -j MASQUERADE

# Enable NAT for traffic from the cluster network to the main network
sudo iptables -t nat -A POSTROUTING -s 10.1.189.0/24 -d 192.168.254.0/24 -j MASQUERADE
```

for persistent iptables

```
   sudo apt-get install iptables-persistent
```

```
   sudo dpkg-reconfigure iptables-persistent
```

Verify the iptables configuration

```
sudo iptables -L -v -n
```

## Next steps

Lets improve the dashboard and remove the annoying
![](images/ico/color/homekube_16.png)[ token login](dashboard-auth.md).

## Tutorials

- [![](images/ico/color/youtube_16.png) ![](images/ico/instructor_16.png)
  23:09 Kubernetes Ingress Tutorial for Beginners](https://www.youtube.com/watch?v=80Ew_fsV4rM)  
   Ingress simply explained
  [[Techworld with Nana](https://www.youtube.com/channel/UCdngmbVKX1Tgre699-XLlUA)]

- [![](images/ico/color/youtube_16.png) ![](images/ico/terminal_16.png) 11:01 Set up MetalLB Load Balancing for Bare Metal Kubernetes](https://www.youtube.com/watch?v=xYiYIjlAgHY)  
  [[Just me and Opensource](https://www.youtube.com/channel/UC6VkhPuCCwR_kG0GExjoozg)]
- [![](images/ico/color/youtube_16.png) ![](images/ico/terminal_16.png) 22:14 Deploy and use Nginx ingress controller](https://www.youtube.com/watch?v=2VUQ4WjLxDg)  
  [[Just me and Opensource](https://www.youtube.com/channel/UC6VkhPuCCwR_kG0GExjoozg)]
