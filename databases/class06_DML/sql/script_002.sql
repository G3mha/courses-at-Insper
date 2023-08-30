USE torneio;

ALTER TABLE jogador
    DROP FOREIGN KEY jogador_ibfk_1; -- fk_equipe

ALTER TABLE jogador
    ADD CONSTRAINT jogador_ibfk_1 -- fk_equipe 
        FOREIGN KEY (nome_equipe) 
        REFERENCES equipe (nome)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
