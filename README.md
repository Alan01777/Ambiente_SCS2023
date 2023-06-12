# Configuração do Ambiente com Docker e Scripts

Este repositório contém os arquivos e scripts necessários para configurar um ambiente com Docker, instalar as dependências do backend e do frontend.

## Pré-requisitos

Certifique-se de ter os seguintes itens instalados em seu sistema:

- Docker
- Docker Compose
- Node.js (para a instalação das dependências do frontend)

## Configuração

1. Clone este repositório para o seu ambiente local.

2. Navegue para o diretório do projeto

## Execução

- No windows use o script ```setup.bat``` (Descontinuado)
- No linux use o script ```setup.sh``` | use: 
```bash
$ chmod +x setup.sh
$ sudo ./setup.sh
```

O script irá iniciar os containers Docker necessários para o ambiente.

2. Aguarde alguns segundos para que os containers sejam inicializados.

3. Após os containers estarem em execução, o script executará os seguintes comandos automaticamente:

- Caso o docker não esteja instalado, o script iniciará (com permissão do usuário) o processo de instalação;
- Instalar as dependências do PHP usando o Composer;
- Configurar o arquivo `.env` movendo-o para o diretório `backend`;
- Gerar a chave do Laravel no container `backend`;
- Instalar as dependências do frontend no diretório `frontend` usando o npm.

4. Aguarde até que o script termine de executar todos os comandos.

5. Após a conclusão do script, seu ambiente deverá estar configurado e pronto para uso.gin