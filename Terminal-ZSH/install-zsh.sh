#!/bin/bash

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

show_spinner() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\'
  local i=0

  while kill -0 "$pid" 2>/dev/null; do
    printf "\r%c" "${spinstr:i++%${#spinstr}:1}"
    sleep $delay
  done

  printf "\r \r"
}

echo -e "${BLUE}⚡ Instalando ZSH... ${NC}\n"
(sudo apt install zsh -y > /dev/null 2>&1) & show_spinner $!

echo -e "${BLUE}🔧 Alterando shell padrão para ZSH... ${NC}\n"
(sudo chsh -s /bin/zsh "$USER" > /dev/null 2>&1) & show_spinner $!

echo -e "${BLUE}🚀 Instalando Oh My Zsh... ${NC}\n"
(sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null 2>&1) & show_spinner $!

export ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

echo -e "${BLUE}✨ Instalando Spaceship Prompt... ${NC}\n"
(git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 > /dev/null 2>&1) & show_spinner $!

echo -e "${BLUE}🔗 Criando link simbólico do tema... ${NC}\n"
(ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" > /dev/null 2>&1) & show_spinner $!

echo -e "${BLUE}🧲 Instalando Zsh Autosuggestions... ${NC}\n"
(git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" > /dev/null 2>&1) & show_spinner $!

echo -e "${BLUE}🖍️ Instalando Zsh Syntax Highlighting... ${NC}\n"
(git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" > /dev/null 2>&1) & show_spinner $!

echo -e "${BLUE}🛠️ Configurando .zshrc... ${NC}\n"
(cp ~/.zshrc ~/.zshrc.backup > /dev/null 2>&1) & show_spinner $!

(sed -i 's/^ZSH_THEME=.*/ZSH_THEME="duellj"/' ~/.zshrc > /dev/null 2>&1) & show_spinner $!
(sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc > /dev/null 2>&1) & show_spinner $!
grep -q "ZSH_THEME=" ~/.zshrc || echo 'ZSH_THEME="duellj"' >> ~/.zshrc

echo -e "${GREEN}✅ Instalação concluída com sucesso!${NC}\n"
echo -e "${CYAN}🔁 Iniciando o ZSH...${NC}\n"

exec zsh
