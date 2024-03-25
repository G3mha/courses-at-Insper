DROP DATABASE IF EXISTS emprestimos;
CREATE DATABASE emprestimos;
USE emprestimos;

CREATE TABLE usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    sobrenome VARCHAR(80) NOT NULL,
    saldo DECIMAL(30 , 2 ) NOT NULL DEFAULT 0.0,
    PRIMARY KEY (id_usuario),
    CONSTRAINT c_saldo CHECK (saldo >= 0.0)
);

CREATE TABLE emprestimo (
    id_emprestimo INT NOT NULL AUTO_INCREMENT,
    id_credor INT NOT NULL,
    id_devedor INT NOT NULL,
    valor_atual DECIMAL(30 , 2) NOT NULL DEFAULT 0.0,
    data_inicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_modificação DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_emprestimo),
    CONSTRAINT fk_credor FOREIGN KEY (id_credor)
        REFERENCES usuario (id_usuario),
    CONSTRAINT fk_devedor FOREIGN KEY (id_devedor)
        REFERENCES usuario (id_usuario),
    CONSTRAINT c_valor CHECK (valor_atual >= 0.0)
);

CREATE TABLE operacao (
    id_operacao INT NOT NULL AUTO_INCREMENT,
    id_emprestimo INT NOT NULL,
    valor DECIMAL(30 , 2 ),
    data_operacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_operacao),
    CONSTRAINT fk_emprestimo FOREIGN KEY (id_emprestimo)
        REFERENCES emprestimo (id_emprestimo)
);

CREATE TABLE movimentacao (
    id_movimentacao INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    valor DECIMAL(30 , 2 ),
    data_operacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_movimentacao),
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario)
);

