## Install a virtual environment
    python3 -m venv venv
    source venv/bin/activate
    pip freeze > requirements.txt
    pip install -r requirements.txt

## Connect a container on Docker
    docker run --rm --name pg-docker -e POSTGRES_PASSWORD=tron -d -p 5432:5432 -v Users/enriccogemha/docker/volumes/postgres:/var/lib/postgresql/data postgres

## Enter in the container's terminal
    docker exec -it pg-docker bash

## Turn-off a container
    docker kill pg-docker

## Change database on Django
    python3 manage.py migrate
    python3 manage.py createsuperuser

## Create app on Heroku
    heroku create `nome-da-aplicacao`
    heroku git:remote -a `nome-da-aplicacao`

## Deploying on Heroku
    git push heroku main


# Containers

## Instalando o postgres pela 1a vez
    docker pull postgres
    mkdir -p $HOME/docker/volumes/postgres

### Executar o container
    docker run --rm --name pg-docker -e POSTGRES_PASSWORD=escolhaumasenha -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres
    docker exec -it pg-docker bash
    psql -h localhost -U postgres
    CREATE DATABASE getit;
    CREATE USER getituser WITH PASSWORD 'getitsenha';
    ALTER ROLE getituser SET client_encoding TO 'utf8';
    ALTER ROLE getituser SET default_transaction_isolation TO 'read committed';
    ALTER ROLE getituser SET timezone TO 'UTC';
    GRANT ALL PRIVILEGES ON DATABASE getit TO getituser;
    \q

### Verificar se o container esta rodando
    docker ps