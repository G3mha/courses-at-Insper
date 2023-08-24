DROP DATABASE IF EXISTS rh;
CREATE DATABASE rh;
USE rh;

DROP TABLE IF EXISTS Funcionario;
CREATE TABLE Funcionario (
    rg VARCHAR(20),
    nome VARCHAR(70),
    salario DECIMAL(10,2),
    telefone VARCHAR(20),
    PRIMARY KEY (rg)
);

DROP TABLE IF EXISTS Departamento;
CREATE TABLE Departamento (
    dep_id INT,
    nome VARCHAR(20),
    PRIMARY KEY (dep_id)
);

DROP TABLE IF EXISTS Funcionario_Departamento;
CREATE TABLE Funcionario_Departamento (
    rg VARCHAR(20),
    dep_id INT,
    PRIMARY KEY (rg, dep_id),
    FOREIGN KEY (rg) REFERENCES Funcionario(rg),
    FOREIGN KEY (dep_id) REFERENCES Departamento(dep_id)
);

-- 2. o relacionamento entre Funcionario e Dependente é 1:N (one to many)