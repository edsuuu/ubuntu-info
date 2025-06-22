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

- Testar a Conexao 

```bash
ssh -T git@github.com

```

### - [Voltar a Pagina Inicial](../README.md)
