#!/bin/bash

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

echo -e "\n${BLUE}✅ Atualizando pacotes...${NC}"

sudo apt update -y && sudo apt upgrade -y

echo -e "${BLUE}⚡ Instalando ZSH...${NC}"

sudo apt install zsh -y

echo -e "${BLUE}🔧 Alterando shell padrão para ZSH ${NC}\n"

chsh -s /bin/zsh

echo -e "${BLUE}🚀 Instalando Oh My Zsh...${NC}\n"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
export ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

echo -e "${BLUE}✨ Instalando Spaceship Prompt...${NC}\n"

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo -e "${BLUE}🧲 Instalando Zsh Autosuggestions...${NC}\n"

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

echo -e "${BLUE}🖍️ Instalando Zsh Syntax Highlighting...${NC}\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"

echo -e "${BLUE}🛠️ Configurando .zshrc...${NC}\n"

cp ~/.zshrc ~/.zshrc.backup

sed -i 's/^ZSH_THEME=.*/ZSH_THEME="duellj"/' ~/.zshrc
sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

grep -q "ZSH_THEME=" ~/.zshrc || echo 'ZSH_THEME="duellj"' >> ~/.zshrc

echo -e "${GREEN}✅ Instalação concluída com sucesso!${NC}\n"
echo -e "${CYAN}🔁 Iniciando o ZSH...${NC}\n"

exec zsh