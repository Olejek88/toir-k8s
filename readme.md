Конфигурация образов Тоирус для развертывания в кластере k8n

Описание:
конфигурационные файлы системы Тоирус делятся на базовый дистрибутив и сервисное ПО
Базовый дистрибутив состоит из:
app-deployment - контейнера приложения Тоирус на базе Yii2 фреймворка
app-service - сервиса приложения (php-fpm) 9002 порт

db-deployment -  контейнера базы данных на базе mysql image
db-service - сервиса MySQL 3306 порт

redis-deployment - контейнера redis на базе базового образа
redis-service - сервиса Redis для подключения приложения (хранит свзяки логинов/пользователей/карточек и экземпляров приложения для SaaS) порт 6379

nginx-deployment - контейнера nginx - веб-сервера приложения 
nginx-service - сервис с настройками внешнего доступа извне кластера 81 порт в кластере
nodeport-service - вариант настройки сервиса с nodeport внешним доступом (проброс на порт из диапазона >30000) 

ingress-* - варианты настройки доступа к кластеру через ingress service 

conf/* - конфигурационные файлы элементов системы
docker-config/* - базовые конфигурационные файлы kubernetes кластера полученные в результате работы kompose (из коробки естественно не работают)

docker-compose - конфигурация связки graylog+mongo+elasticsearch для docker 

graylog/elastic-deployment - контейнер сервиса elasticsearch (нужен для graylog)
graylog/elastic-service - сервис elasticsearch (порты 9200/9300)

graylog/mongo-deployment - контейнер базы данных mongo (нужен для graylog)
graylog/mongo-service - сервис базы данных mongo (порты 27017)

graylog/gray-deployment - контейнер сервиса Graylog (нужен для graylog)
graylog/gray-service - сервис Graylog (порты 9000)

Руководство к действию:
для docker (снаружи директории docker с дистрибутивом)
docker-compose -f docker/docker-compose.yml up -d
docker exec -it docker_app_1 bash
docker-compose -f docker/docker-compose.yml down

перечень 
docker images

docker-compose -f docker/docker-compose.yml build

для kubernetes
kubectl apply -f <имя_сервиса_или_деплоймент>.yaml
уничтожить
kubectl delete svc/service_name
kubectl delete -n default deployment <имя деплоймента>

просмотреть текущие запущенные
kubectl get pods
kubectl get svc

