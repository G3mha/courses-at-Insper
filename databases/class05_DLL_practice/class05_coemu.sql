DROP DATABASE IF EXISTS coemu;
CREATE DATABASE coemu; -- no SQL, SCHEMA e DATABASE significam a mesma coisa
USE coemu;

DROP TABLE IF EXISTS usuario;
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario int NOT NULL,
    nome VARCHAR(100) NOT NULL,
    nickname VARCHAR(30) NOT NULL,
    data_cadastro DATETIME NOT NULL,
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_usuario)
);

ALTER TABLE usuario
ADD UNIQUE (nickname);

ALTER TABLE usuario
MODIFY COLUMN
	id_usuario int NOT NULL AUTO_INCREMENT;

DROP TABLE IF EXISTS comunidade;
CREATE TABLE IF NOT EXISTS comunidade (
    id_comunidade int NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(50) NOT NULL,
    descricao LONGTEXT,
    data_criacao DATETIME NOT NULL,
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_comunidade)
);

ALTER TABLE comunidade
ADD COLUMN (
	id_usuario_dono int NOT NULL,
    FOREIGN KEY (id_usuario_dono) REFERENCES usuario(id_usuario)
);

DROP TABLE IF EXISTS usuario_has_comunidade;
CREATE TABLE IF NOT EXISTS usuario_has_comunidade (
    id_usuario int NOT NULL,
    id_comunidade int NOT NULL,
    PRIMARY KEY (id_usuario, id_comunidade),
	FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
	FOREIGN KEY (id_comunidade) REFERENCES comunidade(id_comunidade)
);

DROP TABLE IF EXISTS discussao;
CREATE TABLE IF NOT EXISTS discussao (
    id_discussao int NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(90) NOT NULL,
    data_criacao DATETIME NOT NULL,
    ativa TINYINT NOT NULL,
    id_comunidade int NOT NULL,
    id_usuario_criador int NOT NULL,
    PRIMARY KEY (id_discussao),
	FOREIGN KEY (id_comunidade) REFERENCES comunidade(id_comunidade),
	FOREIGN KEY (id_usuario_criador) REFERENCES usuario(id_usuario)
);

DROP TABLE IF EXISTS mensagem;
CREATE TABLE IF NOT EXISTS mensagem (
    id_mensagem int NOT NULL AUTO_INCREMENT,
    texto MEDIUMTEXT NOT NULL,
    oculta TINYINT NOT NULL,
    data_envio DATETIME NOT NULL,
    id_discussao int NOT NULL,
    id_usuario_envio int NOT NULL,
    PRIMARY KEY (id_mensagem),
	FOREIGN KEY (id_discussao) REFERENCES discussao(id_discussao),
	FOREIGN KEY (id_usuario_envio) REFERENCES usuario(id_usuario)
);