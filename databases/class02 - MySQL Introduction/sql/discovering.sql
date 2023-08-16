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

SELECT * FROM CD WHERE Nome_CD LIKE '%a';