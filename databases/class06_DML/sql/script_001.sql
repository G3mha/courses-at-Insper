DROP DATABASE IF EXISTS torneio;
CREATE DATABASE torneio;

USE torneio;

CREATE TABLE equipe (
    nome VARCHAR(30) PRIMARY KEY,
    grito VARCHAR(80)
);

CREATE TABLE jogador (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    nome_equipe VARCHAR(30) NOT NULL,
    preferencia INTEGER,
    CONSTRAINT fk_equipe 
        FOREIGN KEY (nome_equipe) 
        REFERENCES equipe (nome)
);
