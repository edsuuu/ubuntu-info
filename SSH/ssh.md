# Instalação do SSH Windows pelo PowerShell/Terminal do Windows <a href="https://apps.microsoft.com/detail/9n0dx20hk701?hl=pt-br&gl=BR" target="_blank">Terminal na Microsoft Store</a>

- Abra o Terminal ou PowerShell 

- Execute como administrador

```bash
Add-WindowsCapability -Online -Name OpenSSH.Client
```
- Verifique se foi instalado

```bash
ssh
```
- Precisar ser retornado:

<img src="image.png" alt="ssh">

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
- Você pode criar uma senha ou deixar em branco

- Com isso você vai ter sua publickey, Vocé vai precisar colocar em authorized_keys no seu servidor para não ter erros

# Configuração para acessar as maquinas via SSH Windows

- Se você ultlizar o VSCODE acesse por ele a pasta .ssh abaixo

```bash
cd "C:\Users\$env:USERNAME\.ssh"
```

```bash
code . 
```
- 
### Volte ao terminal e digite o seguinte comando 

- Criando um Arquivo config para configurar varios servidores

```bash
echo "Host nomeDoServidor
    HostName 100.100.100.100
    IdentityFile id_rsa" >> config

```

# Acessar a maquina 

```bash
ssh nomeDoServidor
```
- Caso esteja conectando pela primeira vai aparecer a seguinte mensagem
- Are you sure you want to continue connecting (yes/no/[fingerprint])?
- Você apenas escreva "yes" e Enter
- Pronto você acessou o seu servidor

### Caso der erro de Permission denied (publickey)

- Verifique-se sua chave Publica esteja na sua VM no arquivo (authorized_keys)
- Veja se a sua publickey está em na sua instancia de VM na sua plataforma de cloud
- Gere outra ChaveSSH e a coloque no servidor 


### - [Voltar a Pagina Inicial](../README.md)
