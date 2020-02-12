kubectl delete svc/nginx
kubectl delete svc/db
kubectl delete svc/app
kubectl delete -n default deployment nginx
kubectl delete -n default deployment db
kubectl delete -n default deployment app
kubectl apply -f app-deployment.yaml
kubectl apply -f db-deployment.yaml
kubectl apply -f nginx-deployment.yaml
kubectl apply -f app-service.yaml
kubectl apply -f db-service.yaml
kubectl apply -f nginx-service.yaml
kubectl get svc
kubectl get pods -A -w