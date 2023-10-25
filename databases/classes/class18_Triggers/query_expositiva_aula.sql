SELECT *
FROM MUSICA M
WHERE M.Nome_Musica LIKE '%tempo%';

DROP FUNCTION IF EXISTS conta_musica_tem_string;

DELIMITER //
CREATE FUNCTION conta_musica_tem_string(palavra VARCHAR(100))
RETURNS INT READS SQL DATA
BEGIN
	DECLARE qtde INT;
    
    SELECT count(*) INTO qtde
	FROM MUSICA M
	WHERE M.Nome_Musica LIKE CONCAT('%', palavra, '%');
    
    RETURN qtde;
END //
DELIMITER ;

SELECT conta_musica_tem_string('a');

SELECT * FROM MUSICA;
UPDATE MUSICA SET Nome_Musica = UPPER(Nome_Musica);
SELECT * FROM MUSICA;

SELECT * FROM MUSICA;

DROP PROCEDURE IF EXISTS transforma_musica;

DELIMITER //
CREATE PROCEDURE transforma_musica ()
BEGIN
	UPDATE MUSICA SET Nome_Musica = UPPER(Nome_Musica);
END //
DELIMITER ;


SELECT * FROM MUSICA;
CALL transforma_musica();
SELECT * FROM MUSICA;

INSERT INTO MUSICA (Codigo_Musica, Nome_Musica, Duracao)
VALUES (1003, 'Tonho e seus amigos', 50);

SELECT * FROM MUSICA order by Codigo_Musica desc;

DROP TRIGGER IF EXISTS up_case_mus;

DELIMITER //
CREATE TRIGGER up_case_mus BEFORE INSERT ON MUSICA
FOR EACH ROW
BEGIN
	SET NEW.Nome_Musica = UPPER(NEW.Nome_Musica);
END //
DELIMITER ;

