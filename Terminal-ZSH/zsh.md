# Instação e configuração do zsh no linux

- Atualizar os pacotes

```bash
sudo apt update -y && sudo apt upgrade -y

```
### Instalar e configurar ZSH

```bash
sudo apt install zsh -y
chsh -s /bin/zsh
zsh
```
### Instalar Oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

```
### Instalar Spaceship Prompt

```bash
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

### Instalar Zsh Autosuggestions
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Instalar Zsh Syntax Highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
### Configurar o bash Shell

```bash
code . .zshrc
```
- editar

```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```
```bash
ZSH_THEME="duellj"
```

- Reabrir o terminal 


### - [Voltar a Pagina Inicial](../README.md)
