docker build -t b03704074/multi-client:latest -t b03704074/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t b03704074/multi-server:latest -t b03704074/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t b03704074/multi-worker:latest -t b03704074/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push b03704074/multi-client:latest
docker push b03704074/multi-server:latest
docker push b03704074/multi-worker:latest

docker push b03704074/multi-client:$SHA
docker push b03704074/multi-server:$SHA
docker push b03704074/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=b03704074/multi-server:$SHA
kubectl set image deployments/client-deployment client=b03704074/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=b03704074/multi-worker:$SHA