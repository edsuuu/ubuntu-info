# Comandos

### Remover as versões anteriores

```bash
sudo apt-get remove \
   docker \
   docker-engine \
   docker.io \
   containerd runc -y
```
```bash
sudo apt update
```

### Instalando o docker-ce 

```bash
sudo apt install \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg-agent \
   software-properties-common -y

```
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

```bash
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y
```

```bash
sudo apt update
```
```bash
sudo apt install docker-ce docker-ce-cli containerd.io -y
```
#### Criando o container do MARIADB
```bash
sudo docker run --restart always -d --name bdmariadb1 -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=root mariadb
```
### - [Voltar a Pagina Inicial](../README.md) 
