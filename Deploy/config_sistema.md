# Requisitos - Para sua Virtual Machine(VM)/ Servidor Ubuntu 20/22

- Ter criado uma VM seja AWS / CLOUD GOOGLE / AZURE
- Deixar o IP publico estático
- Ter portas abertas TCP para HTTP (80) e HTTPS (443) & SSH (22) 

- Ter configurado as chaves SSH para acesso ao terminal [SSH no Windows](../SSH/ssh.md)

# Atualização do Sistema e Instalação de dependencias

```bash
sudo apt update && sudo apt upgrade -y && sudo apt install git curl -y
```

# Instalação do node

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
```

```bash
nvm install 20 && nvm use 20 && node -v && npm -v 
```

# Configuracão PM2

- Veja a configuração do [PM2](PM2.md)