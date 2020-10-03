#Development (Local)
First you need to install docker, kubernetes, virtualbox. You can use docker's build-in kubernetes, but I used to continue with separate kubernetes distribution.
~~~
Check out kubernetes docs for better understanding
~~~
Then you need to install minikube, which is kubernetes manager recommended only for development environment.
https://kubernetes.io/docs/tasks/tools/install-minikube/
~~~
brew install minikube
~~~
Then get kubectl CLI tool to work with your kubernetes master. This is an essential step. You also have kubectl in production environment.
https://kubernetes.io/docs/tasks/tools/install-kubectl/
~~~
brew install kubectl
~~~
After you have all set up, run minikube.
~~~
minikube ip
~~~
If you get you local ip (127.0.0.1), please, stop the minikube (**$ minikube stop**), and run the following command. It is a virtual environment for normal local kubernetes setup
After you did the command below, the other times you will not need to run this, for the future you can run **$ minikube start**.
~~~
minikube start --vm-driver=hyperkit
~~~
Then run the following to be sure you have your services up and running.
~~~
kubectl version --client
~~~
Then to see your kubernetes service.
~~~
kubectl get services
~~~
Create a secret for your postgres password.
~~~
kubectl create secret generic postgres-password --from-literal POSTGRES_PASSWORD=postgres_password
~~~
Finally, run the project
~~~
kubectl apply -f k8s
~~~
Use your minikube ip to go open on browser.


#Production (Deploy)
`
NOTE: For the production, you will need to explore the project in-depth to change credentials and stuff, so I would say it's just a documentation for myself, sorry :)`

First set up google account, create GKE cluster.

Have all set up docker account, docker hub ready to work with.

Then set up Travis CI, don't forget about env variables (docker id, docker password)

Review all credentials for connecting with google. The most important part is the 'deploy' script in travis config file. Watch and check it many times. 

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

FINALLY, TRIGGER DEPLOYMENT

**NOTE: Be aware, I did not mention some little steps, so you will figure out how to do. DON'T ZOMBIE COPY PASTE**