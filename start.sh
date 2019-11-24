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