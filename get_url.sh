#!/bin/bash

# 获取nginx-thrift和media-frontend服务的IP地址和端口号
NGINX_THRIFT_IP=$(microk8s kubectl get svc nginx-thrift -n social-network -o jsonpath='{.spec.clusterIP}')
NGINX_THRIFT_PORT=$(microk8s kubectl get svc nginx-thrift -n social-network -o jsonpath='{.spec.ports[0].nodePort}')

MEDIA_FRONTEND_IP=$(microk8s kubectl get svc media-frontend -n social-network -o jsonpath='{.spec.clusterIP}')
MEDIA_FRONTEND_PORT=$(microk8s kubectl get svc media-frontend -n social-network -o jsonpath='{.spec.ports[0].nodePort}')

# 打印获取到的IP地址和端口号
echo "nginx-thrift IP: $NGINX_THRIFT_IP, Port: $NGINX_THRIFT_PORT"
echo "media-frontend IP: $MEDIA_FRONTEND_IP, Port: $MEDIA_FRONTEND_PORT"

# 构建URL
NGINX_THRIFT_URL="http://$NGINX_THRIFT_IP:$NGINX_THRIFT_PORT"
MEDIA_FRONTEND_URL="http://$MEDIA_FRONTEND_IP:$MEDIA_FRONTEND_PORT"

# 替换locustfile.py中的变量值
sed -i -E "s/GLOBAL_NGINX_FRONTEND_URL\s*=\s*'CHANGE_THIS_URL'/GLOBAL_NGINX_FRONTEND_URL = '$NGINX_THRIFT_URL'/" ./locust/locustfile.py
sed -i -E "s/GLOBAL_MEDIA_FRONTEND_URL\s*=\s*'CHANGE_THIS_URL'/GLOBAL_MEDIA_FRONTEND_URL = '$MEDIA_FRONTEND_URL'/" ./locust/locustfile.py

echo "Updated locustfile.py with new URLs"