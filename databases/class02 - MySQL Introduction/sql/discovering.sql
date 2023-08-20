-- SHOW TABLES;

-- DESCRIBE AUTOR;

-- SELECT * FROM AUTOR
-- ORDER BY NOME_AUTOR DESC;

-- SELECT *
-- FROM AUTOR
-- LIMIT 2;

-- SELECT 
-- 	Nome_CD, 
--     Preco_Venda AS Preco,
--     Preco_Venda * 0.1 AS Desconto
-- FROM CD
-- WHERE Preco_Venda > 12
-- ORDER BY 2 ASC;

-- SELECT * FROM musica WHERE Nome_CD LIKE '%a';


-- SELECT 
-- 	Nome_Musica AS nome_musica_mais_longa 
-- FROM musica
-- ORDER BY Duracao DESC
-- LIMIT 1;

-- SELECT
--     Nome_Gravadora
-- FROM GRAVADORA
-- WHERE Endereco IS NULL;

-- SELECT
--     NOME_CD
-- FROM CD
-- WHERE DATA_LANCAMENTO BETWEEN '1991-01-01' AND '2000-12-31';

-- SELECT
--     NOME_CD
-- FROM CD
-- WHERE 
--     DATA_LANCAMENTO BETWEEN '1991-01-01' AND '2000-12-31'
--     AND PRECO_VENDA <= 10;

SELECT
    DISTINCT CD_INDICADO
FROM CD
WHERE CD_INDICADO IS NOT NULL;