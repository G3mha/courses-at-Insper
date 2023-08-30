DROP DATABASE IF EXISTS torneio;
CREATE DATABASE torneio;
USE torneio;

DROP TABLE IF EXISTS equipe;
CREATE TABLE equipe (
    nome VARCHAR(30),
    grito VARCHAR(80),
    PRIMARY KEY (nome)
);

DROP TABLE IF EXISTS jogador;
CREATE TABLE jogador (
    id int NOT NULL AUTO_INCREMENT,
    nome_equipe VARCHAR(30) NOT NULL,
    nome VARCHAR(80) NOT NULL,
    preferencia int,
	FOREIGN KEY (nome_equipe) REFERENCES equipe(nome),
    PRIMARY KEY (id)
);