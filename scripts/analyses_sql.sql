USE dataimmo;

-- 1. Nombre total d’appartements vendus au 1er semestre 2020
SELECT COUNT(*) AS nombre_appartements
FROM vente
JOIN bien ON vente.id_bien = bien.id_bien
WHERE bien.type_local = 'Appartement'
  AND vente.date BETWEEN '2020-01-01' AND '2020-06-30';
  
-- '31362'

-- 2. Nombre de ventes d’appartement par région pour le 1er semestre 2020
SELECT region.nom_region, COUNT(*) AS nombre_ventes
FROM vente
JOIN bien ON vente.id_bien = bien.id_bien
JOIN commune ON bien.id_commune = commune.id_commune
JOIN region ON commune.id_region = region.id_region
WHERE bien.type_local = 'Appartement'
  AND vente.date BETWEEN '2020-01-01' AND '2020-06-30'
GROUP BY region.nom_region;

-- nom_region nombre_ventes
-- Auvergne-Rhône-Alpes	24959
-- Hauts-de-France	6237
-- Grand Est	27
-- Normandie	139

-- 3. Proportion des ventes d’appartements par le nombre de pièces
SELECT b.total_piece, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM vente v JOIN bien b ON v.id_bien = b.id_bien WHERE b.type_local = 'Appartement') AS proportion
FROM vente v
JOIN bien b ON v.id_bien = b.id_bien
WHERE b.type_local = 'Appartement'
GROUP BY b.total_piece
ORDER BY b.total_piece;

-- total_piece proportion
-- 0	0.09566
-- 1	21.47822
-- 2	31.16192
-- 3	28.58874
-- 4	14.21465
-- 5	3.55207
-- 6	0.64728
-- 7	0.17218
-- 8	0.05421
-- 9	0.02551
-- 10	0.00638
-- 11	0.00319


-- 4. Liste des 10 départements où le prix du mètre carré est le plus élevé
SELECT commune.code_departement, AVG(vente.valeur / bien.surface_carrez) AS prix_m2
FROM vente
JOIN bien ON vente.id_bien = bien.id_bien
JOIN commune ON bien.id_commune = commune.id_commune
WHERE bien.surface_carrez > 0
GROUP BY commune.code_departement
ORDER BY prix_m2 DESC
LIMIT 10;

-- code_departement prix_m2
-- 14	7118.852723754677
-- 01	5011.775255217255
-- 02	3724.2841238394913
-- 03	3548.9229234210147
-- 08	3458.307208426076
-- 62	3365.8621465081924

-- 5. Prix moyen du mètre carré d’une maison en Île-de-France
SELECT AVG(vente.valeur / bien.surface_carrez) AS prix_m2_maison_idf
FROM vente
JOIN bien ON vente.id_bien = bien.id_bien
JOIN commune ON bien.id_commune = commune.id_commune
JOIN region ON commune.id_region = region.id_region
WHERE bien.type_local = 'Maison'
  AND region.id_region = 7
  AND bien.surface_carrez > 0;
  
-- prix_m2_maison_idf
-- 3148.459904002943