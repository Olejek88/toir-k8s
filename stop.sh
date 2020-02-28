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

kubectl patch pvc redis-disk -p '{"metadata":{"finalizers":null}}'
kubectl patch pvc app-disk -p '{"metadata":{"finalizers":null}}'
kubectl patch pvc mysql-disk -p '{"metadata":{"finalizers":null}}'
kubectl patch pv redis-pv -p '{"metadata":{"finalizers":null}}'
kubectl patch pv app-pv -p '{"metadata":{"finalizers":null}}'
kubectl patch pv mysql-pv -p '{"metadata":{"finalizers":null}}'
kubectl delete pvc redis-disk
kubectl delete pvc app-disk
kubectl delete pvc mysql-disk
kubectl delete pv redis-pv
kubectl delete pv mysql-pv
kubectl delete pv app-pv
