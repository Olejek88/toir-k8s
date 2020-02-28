#!/bin/bash

echo docker login
docker login --username=shtrm

echo build toirus images
echo clone source code
#rm -rf toirus-srv
#git clone https://bitbucket.org/4938x8_tes-team/toirus.git toirus-srv
#mkdir -p toirus-srv/logs
#mkdir -p toirus-app
#rm -rf toirus-srv/.git toirus-srv/docs toirus-srv/*.md  toirus-srv/Vagrantfile toirus-srv/.bowerrc toirus-srv/*.bat toirus-srv/bitbucket-pipelines.yml

#echo build toirus images
#docker-compose -f docker-compose.yml build 
#echo push image toirus
#docker push shtrm/toirus:v5.5

echo build nginx images
docker-compose -f docker-compose-nginx.yml build 
echo push image nginx
docker push shtrm/nginx:v1.0

echo pulling big containers to store them locally..
docker pull mariadb:10.4
#docker pull openresty/openresty:alpine
docker pull shtrm/nginx:v1.0
docker pull shtrm/toirus:v5.5
docker pull redis

echo create the Nginx ConfigMap...
kubectl create configmap conf-nginx --from-file=conf/nginx-default/
#kubectl get configmaps conf-nginx -o yaml

echo create the Toirus ConfigMap...
kubectl create configmap conf-toirus --from-file=conf/app/
#kubectl get configmaps conf-toirus -o yaml

/bin/sh ./mkdbsecret.sh

echo * apply DB Secret..
kubectl apply -f secret.yml
#kubectl describe secret mysql-secrets
echo apply DB Persistent Volume..
kubectl apply -f pvc-storage-app.yaml
kubectl apply -f pvc-storage-mysql.yaml
kubectl apply -f pvc-storage-redis.yaml
kubectl get pv

echo apply DB Persistent Volume Claim..
kubectl apply -f pv-storage-app.yaml
kubectl apply -f pv-storage-mysql.yaml
kubectl apply -f pv-storage-redis.yaml
kubectl get pvc

# kubectl describe persistentvolumeclaim mysql-data-disk

echo apply DB Deployment...
kubectl apply -f db-deployment.yaml

echo apply DB Service..
kubectl apply -f db-service.yaml

echo apply Redis and its PV..
kubectl apply -f redis-deployment.yaml
kubectl apply -f redis-service.yaml

echo apply nginx..
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml

echo apply toirus app + php7-fpm..
kubectl apply -f app-deployment.yaml
kubectl apply -f app-service.yaml

#echo Apply Ingress..
#kubectl apply -f ingress.yml

kubectl get all
kubectl get pods -A -w

echo done
