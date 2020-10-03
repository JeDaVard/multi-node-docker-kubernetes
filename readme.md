
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