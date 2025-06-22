# CONFIGURAÇÃO DO PM2

- Instalação
```bash
npm i -g pm2
```

### Clonar repositorio Seja API, FRONT

```bash
git clone https://seurepositorio.com/nome_da_pasta
```
- Permissão a pasta

```bash
chmod -R 750 nome_da_pasta
```
```bash
cd nome_da_pasta
```

```bash
npm install 
```

- Configurar Variáveis de ambiente
```bash
sudo nano .env 
```

- Verificar antes 
```bash
sudo run dev
```

### Buildar o projeto para ultizar o PM2 

```bash
npm run build 
```
### Iniciando o PM2  

```bash
pm2 start dist/server.js --name api
```
- Visualizar o log de todas aplicação
```bash
pm2 log
```
- Listar todos processos
```bash
pm2 ls
```
- Reiniciar algum processo passando o id
```bash
pm2 restart 0
```
- Parando algum processo passando o id
```bash
pm2 stop 0
```

# Configuracão Nginx
- Veja a configuração do [NGINX](NGINX.md)