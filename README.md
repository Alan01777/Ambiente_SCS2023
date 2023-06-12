# Configuração do ambiente de desenvolvimento através de script shell

Este repositório contém os arquivos e scripts necessários para configurar o meu ambiente com Docker e instalar as dependências do backend e do frontend.

<!--
## Pré-requisitos

Certifique-se de ter os seguintes itens instalados no seu sistema:

- Docker
- Docker Compose
- Node.js (para a instalação das dependências do frontend)
-->

## Sobre o Script

O script tem o objetivo de automatizar o processo de configuração do ambiente de desenvolvimento usando o Docker.
Caso o usuário não possua o Docker instalado em sua máquina, o script fará a instalação (com permissão do usuário) de forma automática. O script foi feito com a distribuição do Linux Debian e suas derivações em mente.

O script possui as seguintes funcionalidades:

- Instala o Docker caso necessário;
- Cria um container do Portainer caso ele não exista;
- Instala as dependências do backend (PHP Laravel), gerando a chave da aplicação;
- Instala as dependências do frontend (Node.js).
É importante notar que a configuração do banco de dados deve ser feita manualmente no arquivo .env presente na pasta backend, de forma que o usuário deva especificar o SGBD, o usuário, a senha e a database a ser utilizada.
Por exemplo, caso o usuário deseje usar o PostgreSQL:
```bash
DB_CONNECTION=pgsql
DB_HOST=db
DB_PORT=5432
DB_DATABASE=SCSdb
DB_USERNAME=SCS
DB_PASSWORD=SCS2023
```

Caso o script funcione sem problemas, os containers podem ser acessados nas seguintes portas:

- Backend: http://localhost:80 (Laravel)
- Frontend: http://localhost:5173 (React)
- Portainer: http://locahost:9000

## Execução

1. Clone este repositório para o seu ambiente local.
```bash
$ git clone https://github.com/Alan01777/Ambiente_SCS2023.git
```

2. Navegue até o diretório do projeto.
```bash
$ cd Ambiente_SCS2023
```

3. Dê permissão de execução ao script.
```bash
$ sudo chmod +x setup.sh
```

4. Execute o script como superusuário (sudo) ou root.
```bash
$ sudo ./setup.sh
```