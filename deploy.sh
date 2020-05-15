docker build -t titustwimbly/multi-client:latest -t titustwimbly/mutli-client:$SHA -f ./client/Dockerfile ./client
docker build -t titustwimbly/multi-server:latest -t titustwimbly/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t titustwimbly/multi-worker:latest -t titustwimbly/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push titustwimbly/multi-client:latest
docker push titustwimbly/multi-server:latest
docker push titustwimbly/multi-worker:latest
docker push titustwimbly/multi-client:$SHA
docker push titustwimbly/multi-server:$SHA
docker push titustwimbly/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=titustwimbly/multi-server:$SHA
kubectl set image deployments/client-deployment client=titustwimbly/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=titustwimbly/multi-worker:$SHA