-- Questão 1
SELECT * FROM municipio AS m
INNER JOIN estado AS e ON m.codestado = e.codestado
INNER JOIN regiao AS r ON r.codregiao = e.codregiao
WHERE r.codregiao != 1

SELECT m.* FROM estado AS e 
INNER JOIN municipio AS m ON m.codestado = e.codestado
INNER JOIN regiao AS r ON r.codregiao = e.codregiao
WHERE r.codregiao != 1

SELECT m.* FROM regiao AS r 
INNER JOIN estado AS e ON r.codregiao = e.codregiao
INNER JOIN municipio AS m ON m.codestado = e.codestado
WHERE r.codregiao != 1

-- Questão 2
SELECT nomemunicipio, count(codmunicipio) FROM municipio as m
GROUP BY nomemunicipio
HAVING count(codmunicipio) > 1

SELECT * FROM municipio AS m1
WHERE m1.codmunicipio IN (
    SELECT m2.codmunicipio
    FROM municipio AS m2
    WHERE m1.nomemunicipio = m2.nomemunicipio
    AND m1.codmunicipio != m2.codmunicipio
);







