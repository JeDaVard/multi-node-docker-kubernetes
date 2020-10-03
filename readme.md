
To add your environment variables as secrets do the following.
In google cloud console, open cloud shell and:
~~~
gcloud config set project [project ID]
gcloud config set compute/zone [cloud region]
gcloud container clusters get-credentials [kubernetes cluster name]
~~~
Then add your variables as secret key=value pair following the structure below:
~~~
kubectl create secret generic [secret name] --from-literal [secret key]=[secret value]
~~~

Use ingress-nginx to get an ingress service, and a Google Load Balancer automatically:
https://kubernetes.github.io/ingress-nginx/deploy/#using-helm

Basically you need to use "helm" to simplify your flow with ingress and load balancer:
https://helm.sh/docs

In case you have problem with running helm to install ingress, try this:
Note. Those are deprecated commands, but anyways may temporary help you.
~~~
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm install my-nginx stable/nginx-ingress --set rbac.create=true 
~~~