#!/bin/bash

echo restart pv
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

kubectl apply -f pv-storage-app.yaml
kubectl apply -f pv-storage-mysql.yaml
kubectl apply -f pv-storage-redis.yaml
kubectl apply -f pvc-storage-app.yaml
kubectl apply -f pvc-storage-mysql.yaml
kubectl apply -f pvc-storage-redis.yaml
kubectl get pv
kubectl get pvc
