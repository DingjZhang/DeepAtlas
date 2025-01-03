#!/bin/bash

# 获取nginx-thrift服务的IP地址和端口号
nginx_thrift_info=$(microk8s kubectl get svc nginx-thrift -n social-network -o jsonpath='{.spec.clusterIP}:{.spec.ports[0].nodePort}')
nginx_thrift_url="http://$nginx_thrift_info"

# 获取media-frontend服务的IP地址和端口号
media_frontend_info=$(microk8s kubectl get svc media-frontend -n social-network -o jsonpath='{.spec.clusterIP}:{.spec.ports[0].nodePort}')
media_frontend_url="http://$media_frontend_info"

# 打印获取到的IP地址和端口号
echo "nginx-thrift URL: $nginx_thrift_url"
echo "media-frontend URL: $media_frontend_url"

# 替换locustfile.py中的URL
sed -i "s|GLOBAL_NGINX_FRONTEND_URL = 'CHANGE_THIS_URL'|GLOBAL_NGINX_FRONTEND_URL = '$nginx_thrift_url'|g" locust/locustfile.py
sed -i "s|GLOBAL_MEDIA_FRONTEND_URL = 'CHANGE_THIS_URL'|GLOBAL_MEDIA_FRONTEND_URL = '$media_frontend_url'|g" locust/locustfile.py