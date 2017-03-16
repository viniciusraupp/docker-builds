# haproxy
Criar volume, para armazenar o arquivo de configuração e certificados:

docker volume create vol-haproxy

Criar rede:

docker network create net-web

Reiniciar o serviço:

docker kill -s HUP my-running-haproxy
