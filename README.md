# Terminal com auto complete

[TERMINAL_ZSH](https://github.com/edsuuu/ubuntu-info/blob/main/Terminal-ZSH/zsh.md)

# NodeJs

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

```bash
\. "$HOME/.nvm/nvm.sh"
```

```bash
nvm install 24 && node -v && npm -v 
```

## PHP 8+  Verificar se é o php8.3

```bash
sudo apt-get update && sudo apt install php php-xml php-curl php-mbstring php-pgsql php-mysql php-zip
```

# Composer

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
```

# Docker & Docker composer

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

```bash
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && sudo systemctl start Docker && sudo usermod -aG docker $USER
```

# Database && Apps

```bash
mkdir -p "$HOME/database" && cd "$HOME/database" && curl -fsSL "https://raw.githubusercontent.com/edsuuu/ubuntu-info/refs/heads/main/Docker/docker-compose.yml" -o "$HOME/database/docker-compose.yml" && sudo docker compose -f "$HOME/database/docker-compose.yml" up -d
```

- Para criar um DB dentro do container
```bash
docker exec -it nomeDoContainer bash
```
```bash
psql -U postgres

mysql -U root
```
```bash
create database nome; \q
```

- Para importar um dump 
```bash
docker exec -i postgres_container psql -U postgres -d nomeDobanco < dump.sql

docker exec -i mysql_container mysql -U root -d nomeDobanco < dump.sql
```
- Para fazer um dump do banco atual
```bash
docker exec -t postgres_container pg_dump -U postgres -d banco_atual > dump.sql

docker exec -t mysql_container mysql_dump -U postgres -d banco_atual > dump.sql
```



## SSH GIT

```bash
echo -n "Email do Git: "
read SSH_EMAIL
ssh-keygen -t ed25519 -C "$SSH_EMAIL" -N "" -f "$HOME/.ssh/id_ed25519" && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519
```

- Pegue a chave e configure no git
```bash
cat ~/.ssh/id_ed25519.pub
```

- Depois de configurar no git

```bash
echo -e "Host github\n  User git\n  HostName github.com\n  IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config
```

## Configurando os projetos
```bash
sudo mkdir -p /var/www/projects
cd /var/www/projects
sudo usermod -aG www-data $USER
sudo chown -R www-data:www-data /var/www/projects
sudo chmod -R 775 /var/www/projects
sudo chmod -R 775 storage bootstrap/cache
sudo chown -R www-data:www-data storage bootstrap/cache
newgrp www-data
```

- Aqui passe URL e nome do projeto
```bash
echo "URL DO PROJETO NO GIT:"; echo -n "\n\nDigite o URL do projeto: \n\n"; read url_project; echo -n "Digite o nome do projeto: "; read name_project; git clone $url_project /var/www/projects/$name_project && cd /var/www/projects/$name_project
```

- Copia do env
```bash
cp -R .env.example .env
```

- Mudar as config no env
```bash
sed -i \
-e "s/^APP_NAME=.*/APP_NAME=MeuProjeto/" \
-e "s/^APP_LOCALE=.*/APP_LOCALE=pt-BR/" \
-e "s/^DB_CONNECTION=.*/DB_CONNECTION=mysql/" \
-e "s/^DB_HOST=.*/DB_HOST=127.0.0.1/" \
-e "s/^DB_DATABASE=.*/DB_DATABASE=nomedobanco/" \
-e "s/^DB_USERNAME=.*/DB_USERNAME=root/" \
-e "s/^DB_PASSWORD=.*/DB_PASSWORD=root/" \
-e "s/^APP_URL=.*/APP_URL=projeto.localhost/" \
-e "s/^SESSION_DOMAIN=.*/SESSION_DOMAIN=projeto.localhost/" \
-e "s/^MAIL_MAILER=.*/MAIL_MAILER=smtp/" \
-e "s/^MAIL_HOST=.*/MAIL_HOST=localhost/" \
-e "s/^MAIL_USERNAME=.*/MAIL_USERNAME=null/" \
-e "s/^MAIL_PASSWORD=.*/MAIL_PASSWORD=null/" \
-e "s/^AWS_ACCESS_KEY_ID=.*/AWS_ACCESS_KEY_ID=minioadmin/" \
-e "s/^AWS_SECRET_ACCESS_KEY=.*/AWS_SECRET_ACCESS_KEY=minioadmin/" \
-e "s/^AWS_USE_PATH_STYLE_ENDPOINT=.*/AWS_USE_PATH_STYLE_ENDPOINT=true/" \
.env
```

- Instalando dependencias
```bash
composer install && npm i && npm run build 
```

- Key
```bash
php artisan key:generate 
```

- Migrates
```bash
php artisan migrate
```


- Atualiza o arquivo padrão do apache
```bash
sudo tee /etc/apache2/sites-available/000-default.conf > /dev/null << 'EOF'
<VirtualHost *:80>
    ServerName minio.localhost

    ProxyPreserveHost On
    ProxyPass / http://localhost:9001/
    ProxyPassReverse / http://localhost:9001/

    ErrorLog ${APACHE_LOG_DIR}/minio.log
    CustomLog ${APACHE_LOG_DIR}/minio.log combined
</VirtualHost>

<VirtualHost *:80>
    ServerName mailpit.localhost

    ProxyPreserveHost On
    ProxyPass / http://localhost:8025/
    ProxyPassReverse / http://localhost:8025/

    ErrorLog ${APACHE_LOG_DIR}/email_local_error.log
    CustomLog ${APACHE_LOG_DIR}/email_local_access.log combined
</VirtualHost>

<VirtualHost *:80>
    ServerName agendamento.localhost
    DocumentRoot /var/www/projects/agendamento/public

    <Directory /var/www/projects/agendamento/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/agendamento-error.log
    CustomLog ${APACHE_LOG_DIR}/agendamento-access.log combined
</VirtualHost>
EOF
```

- Configurando o hosts
```bash
echo -e "127.0.0.1 minio.localhost\n127.0.0.1 mailpit.localhost\n127.0.0.1 agendamento.localhost" | sudo tee -a /etc/hosts > /dev/null
```

- Ativando os modulos e reiniciando
```bash
sudo a2enmod proxy proxy_http rewrite && sudo systemctl restart apache2
```