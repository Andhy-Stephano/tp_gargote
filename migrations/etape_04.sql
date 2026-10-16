-- Étape 04 : Certains clients sont des habitués, je veux les reconnaître

-- Table des clients (habitués)
CREATE TABLE client (
    id_client INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom       VARCHAR(100) NOT NULL
);

-- Lien facultatif entre commande et client (pas de NOT NULL)
ALTER TABLE commande
    ADD COLUMN id_client INTEGER REFERENCES client (id_client);

-- Données de test : deux habitués
INSERT INTO client (nom) VALUES
    ('Hery Randria'),
    ('Voahangy Rabe');

-- Rattacher certaines commandes à leur client
--  ( commande 2 reste sans client : client de passage)
UPDATE commande
SET id_client = (SELECT id_client FROM client WHERE nom = 'Hery Randria')
WHERE id_commande IN (1, 4);

UPDATE commande
SET id_client = (SELECT id_client FROM client WHERE nom = 'Voahangy Rabe')
WHERE id_commande = 3;