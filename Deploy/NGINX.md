
# Instalação do NGINX 

```bash
sudo apt install nginx -y && sudo systemctl start nginx
```

# Verificar o IP da maquina "Welcome to NGINX"

```bash
sudo systemctl status nginx
```
- Ou

```bash
curl 127.0.0.1
```
# Pré Configuração

```bash
cd /etc/nginx/sites-enabled/ && sudo rm -rf default
```

- Gerar um novo arquivo

```bash
sudo nano seudominio.com.br
```
- Alterar os arquivos antes de colar de "seudominio.com.br" para o seu dominio de preferencia

Configuraçao [Nginx HTTP](nginx-HTTP.md)
 
- Para HTTPS gerar os certificado SSL antes

Certificado [Certificado SSL](certificado_ssl.md)

Configuraçao [Nginx HTTPS](nginx-HTTPS.md) 


```bash
sudo nginx -t && sudo systemctl restart nginx 
```
### - [Voltar](../README.md) 


