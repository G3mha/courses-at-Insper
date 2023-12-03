DROP DATABASE IF EXISTS foodtruck;
CREATE DATABASE foodtruck;
USE foodtruck;

DROP TABLE IF EXISTS Ingrediente;
CREATE TABLE Ingrediente (
	nome VARCHAR(20),
    tipo VARCHAR(45),
    calorias INT,
    preco_unitario DECIMAL(10,2),
    quantidade FLOAT,
    PRIMARY KEY (nome)
);

DROP TABLE IF EXISTS Prato;
CREATE TABLE Prato (
	nome VARCHAR(20),
    preco DECIMAL(10,2),
    PRIMARY KEY (nome)
);

DROP TABLE IF EXISTS Ingrediente_Prato;
CREATE TABLE Ingrediente_Prato (
	nome_prato VARCHAR(45),
	nome_ingrediente VARCHAR(45),
    quantidade FLOAT,
    PRIMARY KEY (nome_prato, nome_ingrediente),
	FOREIGN KEY (nome_prato) REFERENCES Prato(nome),
	FOREIGN KEY (nome_ingrediente) REFERENCES Ingrediente(nome)
);

ALTER TABLE Ingrediente
ADD COLUMN (
	peso FLOAT
);

ALTER TABLE Ingrediente
MODIFY COLUMN
	tipo VARCHAR(100)