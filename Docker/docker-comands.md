### DOCKER

# Parar Todos os Containers
docker stop $(docker ps -aq)

# Remover Todos os Containers
docker rm $(docker ps -aq)

# Remover Todas as Imagens
docker rmi $(docker images -q)

# Remover Todos os Volumes
docker volume rm $(docker volume ls -q)

# Docker remover tudo junto
docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker rmi $(docker images -q) && docker volume rm $(docker volume ls -q)

# Docker adicionar usuário sem sudo
sudo usermod -aG docker $USER

# Acessar o MySQL dentro de um container
docker exec -it hostnameDoDockerOuID mysql -u root -p 
