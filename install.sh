#!/bin/bash

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while kill -0 $pid 2>/dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
}

echo -e "${YELLOW}🔐 Solicitando senha sudo para cache...${NC}\n"
sudo -v

( while true; do sudo -n true; sleep 60; done; ) &

echo -e "\n${BLUE}✅ Atualizando pacotes...${NC}\n"

(sudo apt update -y && sudo apt upgrade -y) > /dev/null 2>&1 & spinner

echo -e "${BLUE}⚡ Instalando Neofetch...${NC}\n"

(sudo apt install neofetch -y) > /dev/null 2>&1 & spinner

echo -e "${BLUE}⚡ Instalando ZSH...${NC}\n"

(sudo apt install zsh -y) > /dev/null 2>&1 & spinner

echo -e "${BLUE}🔧 Alterando shell padrão para ZSH (será solicitada sua senha)...${NC}\n"

sudo chsh -s /bin/zsh "$USER"

echo -e "${BLUE}🚀 Instalando Oh My Zsh...${NC}\n"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
export ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}


echo -e "${BLUE}✨ Instalando Spaceship Prompt...${NC}\n"

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


echo -e "${BLUE}🧲 Instalando Zsh Autosuggestions...${NC}\n"

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"


echo -e "${BLUE}🖍️ Instalando Zsh Syntax Highlighting...${NC}\n"
echo ""
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"

echo -e "${BLUE}🛠️ Configurando .zshrc...${NC}\n"

cp ~/.zshrc ~/.zshrc.backup

sed -i 's/^ZSH_THEME=.*/ZSH_THEME="duellj"/' ~/.zshrc
sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

grep -q "ZSH_THEME=" ~/.zshrc || echo 'ZSH_THEME="duellj"' >> ~/.zshrc

echo -e "${GREEN}✅ Instalação concluída com sucesso!${NC}\n"
echo -e "${CYAN}🔁 Iniciando o ZSH...${NC}\n"

echo -e "${BLUE}🔎 Verificando se o NVM já está instalado...${NC}\n"

if command -v nvm &> /dev/null; then
    echo -e "${YELLOW}🚨 NVM já está instalado. Pulando instalação...${NC}\n"
else
    echo -e "${BLUE}⬇️ Instalando NVM...${NC}\n"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    echo '
    # NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    ' >> ~/.zshrc

    echo -e "${BLUE}⬇️ Instalando Node.js versão 24...${NC}\n"

    zsh -c "source ~/.zshrc && nvm install 24"

    echo -e "${GREEN}✅ Node.js instalado com sucesso!${NC}\n"

    zsh -c "node -v && npm -v"
fi

echo -e "${BLUE}⬇️ Instalando PHP 8...${NC}\n"

sudo apt-get update
(sudo apt-get install apache2 php libapache2-mod-php) > /dev/null 2>&1 & spinner
(sudo apt-get install php-xml php-curl php-opcache php-gd php-sqlite3 php-mbstring php-pgsql php-mysql) > /dev/null 2>&1 & spinner

a2dismod mpm_event
a2dismod mpm_worker
a2enmod  mpm_prefork
a2enmod  rewrite
a2enmod  php8.3
service apache2 restart

echo -e "${BLUE}🔄 Instalado o composer...${NC}\n"

if command -v php &> /dev/null; then
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"

    sudo mv composer.phar /usr/local/bin/composer

    zsh -c "composer --version"
fi

echo -e "\n${BLUE}🔄 Instalado o docker ${NC}\n"

sudo apt-get update
(sudo apt-get install ca-certificates curl ) > /dev/null 2>&1 & spinner
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update 

echo -e "${BLUE}🔄 Instalado o docker-compose ${NC}\n"

(sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y) > /dev/null 2>&1 & spinner && sudo usermod -aG docker $USER

echo -e "${BLUE}🔎 Verificando se o Docker daemon está ativo...${NC}\n"
if sudo systemctl is-active --quiet docker; then
    echo -e "${GREEN}✅ Docker já está rodando.${NC}\n"
else
    echo -e "${YELLOW}⚡ Iniciando o Docker...${NC}\n"
    sudo systemctl start docker
fi

echo -e "${BLUE}🛠️ Criando MySQL e Mailpit com Docker Compose...${NC}\n"
mkdir -p "$HOME/database"
curl -fsSL "https://raw.githubusercontent.com/edsuuu/ubuntu-info/refs/heads/main/Docker/docker-compose.yml" -o "$HOME/database/docker-compose.yml"

if [ -f "$HOME/database/docker-compose.yml" ]; then
    echo -e "${GREEN}✅ docker-compose.yml encontrado. Subindo containers...${NC}\n"
    sudo docker compose -f "$HOME/database/docker-compose.yml" up -d
else
    echo -e "${RED}❌ docker-compose.yml não encontrado. Abortando criação dos containers.${NC}\n"
fi

echo -e "\n${BLUE}🔑 Instalando SSH...${NC}\n"
(sudo apt install openssh-client openssh-server -y) > /dev/null 2>&1 & spinner

echo -e "${BLUE}📧 Digite o e-mail para gerar a chave SSH:${NC}\n"
read -rp "Email: " SSH_EMAIL
ssh-keygen -t ed25519 -C "$SSH_EMAIL" -N "" -f "$HOME/.ssh/id_ed25519"

echo -e "${BLUE}🔑 Adicionando chave SSH ao ssh-agent...${NC}\n"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo -e "${BLUE}🔧 Configurando SSH para GitHub...${NC}\n"
mkdir -p ~/.ssh
touch ~/.ssh/config
echo -e "Host github\n    HostName github.com\n    IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config

echo -e "${GREEN}✅ Configuração SSH concluída.${NC}\n"

neofetch

echo -e "${GREEN}✅ Execute o comando zsh no seu terminal.${NC}\n"

exec zsh