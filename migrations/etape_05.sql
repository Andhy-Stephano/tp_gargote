-- Étape 05 : Je veux savoir quel serveur a pris la commande et à quelle table

-- Table des serveurs
CREATE TABLE serveur (
    id_serveur INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom        VARCHAR(100) NOT NULL
);

-- Table des tables de la salle (nom évité : "table" est un mot réservé)
CREATE TABLE table_salle (
    id_table_salle INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    numero INTEGER NOT NULL UNIQUE CHECK (numero > 0)
);

-- Données de test : 2 serveurs et 8 tables
INSERT INTO serveur (nom) VALUES
    ('Njaka Rakoto'),
    ('Lalao Rasoa');

INSERT INTO table_salle (numero) VALUES
    (1), (2), (3), (4), (5), (6), (7), (8);

-- Lier commande au serveur (d'abord facultatif) et à la table (facultatif)
ALTER TABLE commande
    ADD COLUMN id_serveur INTEGER REFERENCES serveur (id_serveur);

ALTER TABLE commande
    ADD COLUMN id_table_salle INTEGER REFERENCES table_salle (id_table_salle);

-- Remplir pour les commandes existantes
-- Commandes 1, 2, 3 : Njaka ; commande 4 : Lalao
UPDATE commande
SET id_serveur = (SELECT id_serveur FROM serveur WHERE nom = 'Njaka Rakoto')
WHERE id_commande IN (1, 2, 3);

UPDATE commande
SET id_serveur = (SELECT id_serveur FROM serveur WHERE nom = 'Lalao Rasoa')
WHERE id_commande = 4;

-- Tables : commande 1 -> table 3, commande 2 -> table 5, commande 4 -> table 1
-- La commande 3 reste sans table : plat à emporter
UPDATE commande
SET id_table_salle = (SELECT id_table_salle FROM table_salle WHERE numero = 3)
WHERE id_commande = 1;

UPDATE commande
SET id_table_salle = (SELECT id_table_salle FROM table_salle WHERE numero = 5)
WHERE id_commande = 2;

UPDATE commande
SET id_table_salle = (SELECT id_table_salle FROM table_salle WHERE numero = 1)
WHERE id_commande = 4;

-- Le serveur devient obligatoire (toutes les lignes sont maintenant remplies)
ALTER TABLE commande
    ALTER COLUMN id_serveur SET NOT NULL;