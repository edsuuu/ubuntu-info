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