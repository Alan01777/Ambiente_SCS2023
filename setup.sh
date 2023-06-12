#!/bin/bash

echo "Iniciando o setup do ambiente..."

# Função para verificar a instalação de uma dependência
check_dependency() {
    if ! command -v "$1" &>/dev/null; then
        return 1
    fi
    return 0
}

# Verificar se o Docker está instalado
if ! check_dependency "docker"; then
    echo "Docker não encontrado."
    read -p "Deseja instalar o Docker? (y/n): " install_docker
    if [ "$install_docker" = "y" ]; then
        # Atualizando os pacotes
        apt-get update -y

        curl -fsSL https://get.docker.com | bash
    else
        echo "Docker não instalado. Encerrando o setup."
        exit 1
    fi
fi

# Verificar se o Node.js e o npm estão instalados
#/if ! check_dependency "node" || ! check_dependency "npm"; then
#    echo "Node.js e/ou npm não encontrados."
#    read -p "Deseja instalar o Node.js e o npm? (y/n): " install_node_npm
#    if [ "$install_node_npm" = "y" ]; then
#        echo "Instalando Node.js e npm..."
#        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
#        source ~/.bashrc
#        nvm install node
#    else
#        echo "Node.js e npm não instalados. Encerrando o setup."
#        exit 1
#    fi
#fi

# Inicializar o docker
echo ""
if ! sudo systemctl is-active --quiet docker; then
    echo "Iniciando o serviço do Docker. Isso pode levar alguns segundos..."
    # Tempo de espera necessário para poder inicar serviço do docker
    sleep 60
    sudo systemctl start docker
fi

# Verificar se o container Portainer já existe
if docker inspect portainer &>/dev/null; then
    echo "Container Portainer já existe. Pulando a criação do Portainer."
elif docker ps --format "{{.Ports}}" | grep -q ":9000->"; then
    echo "Já existe um container usando a porta 9000. Pulando a criação do container Portainer."
else
    # Subindo o container Portainer CE
    echo "Criando o container Portainer..."
    docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
fi

fi
# Subir os containers
echo ""
echo "Subindo os containers..."
docker compose up -d

# Aguardar alguns segundos para os containers iniciarem
echo ""
echo "Aguardando os containers serem inicializados..."
sleep 15

# Acessar o container e executar o comando "composer install"
echo ""
echo "Instalando as dependências do PHP..."
docker compose exec backend composer install

# Copiar o arquivo .env.example para o diretório do backend
echo ""
echo "Configurando o arquivo .env..."
cp backend/.env.example backend/.env

# Executar o comando "php artisan key:generate" no container backend
echo ""
echo "Gerando a chave do Laravel..."
docker compose exec backend php artisan cache:clear
docker compose exec backend chmod -R 775 storage/
docker compose exec backend composer dump-autoload
chmod 664 backend/.env
docker compose exec backend php artisan key:generate

# Acessar o diretório "frontend" e executar "npm install"
#echo "Instalando as dependências do frontend..."
#cd frontend
#npm install

echo "Setup concluído com sucesso!"

echo "Portas usadas pelos containers:"
echo "Backend: http://localhost:80"
echo "Frontend: http://localhost:5173"
echo "Portainer: http://locahost:8000"
echo "Postgres: 5432"
