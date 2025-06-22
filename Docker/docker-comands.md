### DOCKER

# Parar Todos os Containers
```bash
docker stop $(docker ps -aq)
```
# Remover Todos os Containers
```bash
docker rm $(docker ps -aq)
```
# Remover Todas as Imagens
```bash
docker rmi $(docker images -q)
```
# Remover Todos os Volumes
```bash
docker volume rm $(docker volume ls -q)
```
# Docker remover tudo junto
```bash
docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker rmi $(docker images -q) && docker volume rm $(docker volume ls -q)
```

# Docker adicionar usuário sem sudo
```bash
sudo usermod -aG docker $USER
```
# Acessar o MySQL dentro de um container
```bash
docker exec -it hostnameDoDockerOuID mysql -u root -p 
```