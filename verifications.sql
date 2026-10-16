-- Étape 01 : plats plus cher au moins cher
SELECT nom, prix
FROM plat
ORDER BY prix DESC;


-- Étape 02 : nombre de plats par catégorie (y compris les catégories sans plat)
SELECT c.nom AS categorie, COUNT(p.id_plat) AS nb_plats
FROM categorie c
LEFT JOIN plat p ON p.id_categorie = c.id_categorie
GROUP BY c.id_categorie, c.nom
ORDER BY c.nom;


-- Étape 03 : montant total de chaque commande
SELECT c.id_commande,
       c.date_commande,
       SUM(lc.quantite * p.prix) AS montant_total
FROM commande c
JOIN ligne_commande lc ON lc.id_commande = c.id_commande
JOIN plat p ON p.id_plat = lc.id_plat
GROUP BY c.id_commande, c.date_commande
ORDER BY c.id_commande;