## CRIAR UM SERVIDOR E CONECTAR AS CHAVE SSH

### Passo 1 - Atualizar o S.O

```bash
sudo apt update && sudo apt upgrade -y
```
###
### Passo 2 - Instalação do node
###
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
```

```bash
nvm install 20
```

```bash
nvm use 20
```

###
### Passo 3 - Instalação de Lib 
###

```bash
sudo apt install git curl  -y
```

- PM2 para deploy NODEJS 

```bash
npm i -g pm2
```

###
### Passo 4 - Nginx COMANDOS
###

```bash
sudo systemctl start nginx 
```

```bash
sudo systemctl status nginx 
```

```bash
sudo systemctl stop nginx 
```

###
### Clonar repositorio 
###

```bash
git clone https://seurepositorio.com/nome_da_pasta
```
- PERMISSAO A PASTA 

```bash
chmod -R 750 nome_da_pasta
```

### Configuracão Nginx 

[Nginx HTTPS](NGINX.md)