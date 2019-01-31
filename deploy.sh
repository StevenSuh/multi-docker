docker build -t stevenesuh/multi-client:latest -t stevenesuh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stevenesuh/multi-server:latest -t stevenesuh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stevenesuh/multi-worker:latest -t stevenesuh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push stevenesuh/multi-client:latest
docker push stevenesuh/multi-server:latest
docker push stevenesuh/multi-worker:latest

docker push stevenesuh/multi-client:$SHA
docker push stevenesuh/multi-server:$SHA
docker push stevenesuh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=stevenesuh/multi-client:$SHA
kubectl set image deployments/server-deployment server=stevenesuh/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=stevenesuh/multi-worker:$SHA
