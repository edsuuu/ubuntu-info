[Voltar](../README.md)
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