kubectl delete svc/nginx
kubectl delete svc/db
kubectl delete svc/mongo
kubectl delete svc/redis
kubectl delete svc/elasticsearch
kubectl delete svc/gray
kubectl delete svc/app
kubectl delete svc/node
kubectl delete -n default deployment nginx
kubectl delete -n default deployment db
kubectl delete -n default deployment mongo
kubectl delete -n default deployment redis
kubectl delete -n default deployment elasticsearch
kubectl delete -n default deployment gray
kubectl delete -n default deployment app
kubectl delete -n default deployment node
kubectl apply -f app-deployment.yaml
kubectl apply -f db-deployment.yaml
kubectl apply -f redis-deployment.yaml
kubectl apply -f nginx-deployment.yaml
kubectl apply -f node-deployment.yaml
kubectl apply -f graylog/mongodb-deployment.yaml
kubectl apply -f graylog/elastic-deployment.yaml
#kubectl apply -f graylog/gray-deployment.yaml
#kubectl apply -f graylog/gray-service.yaml
kubectl apply -f graylog/elastic-service.yaml
kubectl apply -f graylog/mongodb-service.yaml
kubectl apply -f app-service.yaml
kubectl apply -f db-service.yaml
kubectl apply -f redis-service.yaml
kubectl apply -f nginx-service.yaml
kubectl apply -f node-service.yaml
kubectl get svc
kubectl get pods -A -w