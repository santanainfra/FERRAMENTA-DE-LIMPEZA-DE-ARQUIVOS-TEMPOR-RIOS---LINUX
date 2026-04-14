# FERRAMENTA DE LIMPEZA DE ARQUIVOS TEMPORÁRIOS - LINUX
## Desktop + Servidor

## 📌 Sobre o Projeto
Script em Bash desenvolvido para realizar limpeza segura e eficiente de arquivos temporários em sistemas Linux, tanto em ambientes **Desktop quanto Servidor**.

O objetivo é liberar espaço em disco, melhorar o desempenho e manter o sistema organizado.

---

## ⚙️ Funcionalidades

### 🧹 Limpeza de Diretórios Temporários
- `/tmp`
- `/var/tmp`

### 👤 Limpeza de Cache de Usuários
- Remove arquivos de cache em `/home/*/.cache`

### 🔐 Limpeza de Cache do Root
- Limpeza de `/root/.cache`

### 📦 Limpeza de Cache de Pacotes
Compatível com:
- APT (Debian/Ubuntu)
- DNF (Fedora)
- YUM (CentOS/RHEL)
- Pacman (Arch Linux)
- Zypper (openSUSE)

---

### 📜 Limpeza de Logs
- Redução de logs do `systemd` com:
  - `journalctl --vacuum-time=7d`

---

### 🗑️ Limpeza de Lixeira
- Remove arquivos em:
  - `/home/*/.local/share/Trash`

---

### 📦 Limpeza de Snap e Flatpak
- Remove caches e pacotes não utilizados

---

### 🚀 Modo Limpeza Completa
Executa todas as rotinas automaticamente:
- Limpeza de temporários
- Cache de usuários e root
- Cache de pacotes
- Logs
- Lixeira
- Snap/Flatpak

---

▶️Como Executar
1. Dar permissão de execução:
chmod +x cleanup.sh

2. Executar como root:
sudo ./cleanup.sh

⚠️ Requisitos
. Distribuição Linux com Bash
. Permissões de superusuário (root)
⚠️ Avisos Importantes
. O script remove arquivos permanentemente
. Não há confirmação para todas as operações
. Recomenda-se uso em ambiente controlado ou com backup

---

## 📂 Estrutura do Projeto

```bash
.
├── cleanup.sh
└── README.md
