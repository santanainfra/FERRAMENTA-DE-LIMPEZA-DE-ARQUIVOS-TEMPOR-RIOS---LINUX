#!/bin/bash

# =====================================================
# FERRAMENTA DE LIMPEZA DE ARQUIVOS TEMPORÁRIOS - LINUX
# DESKTOP + SERVIDOR
# =====================================================

# --------- VERIFICA ROOT ---------
if [[ $EUID -ne 0 ]]; then
    echo -e "\e[31mExecute este script como ROOT (sudo).\e[0m"
    read -p "Pressione ENTER para sair"
    exit 1
fi

pause_step() {
    echo ""
    read -p "Pressione ENTER para continuar"
}

progress() {
    echo -e "\n🧹 $1"
    sleep 1
}

# --------- FUNÇÕES DE LIMPEZA ---------
clean_tmp() {
    progress "Limpando /tmp e /var/tmp..."
    rm -rf /tmp/* /var/tmp/*
    echo "✔ Diretórios temporários limpos."
}

clean_cache_users() {
    progress "Limpando cache de usuários..."
    for d in /home/*/.cache; do
        [[ -d "$d" ]] && rm -rf "$d"/*
    done
    echo "✔ Cache de usuários limpo."
}

clean_cache_root() {
    progress "Limpando cache do root..."
    rm -rf /root/.cache/*
    echo "✔ Cache do root limpo."
}

clean_package_cache() {
    progress "Limpando cache de pacotes..."

    if command -v apt &>/dev/null; then
        apt clean
    elif command -v dnf &>/dev/null; then
        dnf clean all
    elif command -v yum &>/dev/null; then
        yum clean all
    elif command -v pacman &>/dev/null; then
        pacman -Scc --noconfirm
    elif command -v zypper &>/dev/null; then
        zypper clean
    else
        echo "Gerenciador de pacotes não identificado."
    fi

    echo "✔ Cache de pacotes limpo."
}

clean_logs() {
    progress "Limpando logs antigos..."
    journalctl --vacuum-time=7d 2>/dev/null
    echo "✔ Logs do systemd reduzidos (7 dias)."
}

clean_trash() {
    progress "Limpando lixeira..."
    rm -rf /home/*/.local/share/Trash/*
    echo "✔ Lixeira limpa."
}

clean_snap_flatpak() {
    progress "Limpando Snap / Flatpak..."

    command -v snap &>/dev/null && snap clean
    command -v flatpak &>/dev/null && flatpak uninstall --unused -y

    echo "✔ Snap/Flatpak verificados."
}

full_cleanup() {
    echo -e "\n⚠️ LIMPEZA COMPLETA (RECOMENDADO)"
    read -p "Deseja continuar? (S/N): " c
    [[ ! "$c" =~ ^[sS]$ ]] && return

    clean_tmp
    clean_cache_users
    clean_cache_root
    clean_package_cache
    clean_logs
    clean_trash
    clean_snap_flatpak

    echo -e "\n✅ Limpeza completa finalizada."
}

show_disk_usage() {
    echo -e "\n📊 Uso de disco:"
    df -h /
}

# --------- MENU ---------
while true; do
    clear
    echo -e "\e[36m=============================================\e[0m"
    echo -e "\e[36m  FERRAMENTA DE LIMPEZA DE ARQUIVOS TEMP\e[0m"
    echo -e "\e[36m     Desktop + Servidor Linux\e[0m"
    echo -e "\e[36m=============================================\e[0m\n"

    show_disk_usage
    echo ""

    echo "1  - Limpar /tmp e /var/tmp"
    echo "2  - Limpar cache dos usuários"
    echo "3  - Limpar cache do root"
    echo "4  - Limpar cache de pacotes"
    echo "5  - Limpar logs antigos (journalctl)"
    echo "6  - Limpar lixeira"
    echo "7  - Limpeza COMPLETA (recomendado)"
    echo "0  - Sair"
    echo ""

    read -p "Digite o número da opção desejada: " opt

    case $opt in
        1) clean_tmp; pause_step ;;
        2) clean_cache_users; pause_step ;;
        3) clean_cache_root; pause_step ;;
        4) clean_package_cache; pause_step ;;
        5) clean_logs; pause_step ;;
        6) clean_trash; pause_step ;;
        7) full_cleanup; pause_step ;;
        0) echo "Saindo..."; exit 0 ;;
        *) echo "Opção inválida."; pause_step ;;
    esac
done
