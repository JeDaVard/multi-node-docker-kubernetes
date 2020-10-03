docker build -t jedavard/multi-client:latest -t jedavard/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jedavard/multi-server:latest -t jedavard/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jedavard/multi-worker:latest -t jedavard/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jedavard/multi-client:latest
docker push jedavard/multi-server:latest
docker push jedavard/multi-worker:latest
docker push jedavard/multi-client:$SHA
docker push jedavard/multi-server:$SHA
docker push jedavard/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jedavard/multi-client:$SHA
kubectl set image deployments/server-deployment server=jedavard/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jedavard/multi-worker:$SHA

# This is a new method to restart all or specific objects
#kubectl rollout restart deployments
