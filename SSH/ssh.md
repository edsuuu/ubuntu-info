# Geração das chave SSH
- Windows 
```bash
ssh-keygen -f "C:\Users\$env:USERNAME\.ssh\nomedachavessh" -t rsa -b 4096
```
- Sem nome do usuario do pc
```bash
ssh-keygen -t rsa -b 4096 -C "" -f "C:\Users\$env:USERNAME\.ssh\nomedachavessh"
```
- Linux 
```bash
ssh-keygen -f ~/.ssh/nome_da_chave -t rsa -b 4096
```
- Sem nome do usuario do pc
```bash
ssh-keygen -t rsa -b 4096 -C "" -f "$HOME/.ssh/nomedachavessh" 
```
```bash
echo "Host nomeDoServidor
    HostName 100.100.100.100
    IdentityFile id_rsa" >> config

```

# Geração da chave SSH para conectar com o github

- No linux / Windows

```bash
ssh-keygen -t ed25519 -C "seu-email@example.com"

```

- Setar o agente "Não precisa no windows"

```bash
eval "$(ssh-agent -s)"
```
- Adicionar a chave privada ao agente "Não precisa no windows"

```bash
ssh-add ~/.ssh/id_ed25519

```
- Pegar a chave e add ao github
```bash
cat ~/.ssh/id_ed25519.pub
```
- No windows
```bash
cat "C:\Users\$env:USERNAME\.ssh\id_ed25519.pub"
```

```bash
ssh -T git@github.com

```

