-- Étape 03 : J'enregistre les commandes : la date, quels plats, et combien de chaque

-- Table commandes
CREATE TABLE commande (
    id_commande   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_commande DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Table d'association : un plat dans une commande
CREATE TABLE ligne_commande (
    id_commande INTEGER NOT NULL REFERENCES commande (id_commande),
    id_plat     INTEGER NOT NULL REFERENCES plat (id_plat),
    quantite    INTEGER NOT NULL CHECK (quantite > 0),
    PRIMARY KEY (id_commande, id_plat)
);

-- Données de test : 4 commandes
INSERT INTO commande (date_commande) VALUES
    ('2026-10-12'),
    ('2026-10-12'),
    ('2026-10-13'),
    ('2026-10-13');

-- Commande 1 : 2 Romazava + 2 Ranon'ampango
INSERT INTO ligne_commande (id_commande, id_plat, quantite) VALUES
    (1, (SELECT id_plat FROM plat WHERE nom = 'Romazava'), 2),
    (1, (SELECT id_plat FROM plat WHERE nom = 'Ranon''ampango'), 2);

-- Commande 2 : 1 Mi sao + 1 Soupe chinoise + 1 Ranon'ampango
INSERT INTO ligne_commande (id_commande, id_plat, quantite) VALUES
    (2, (SELECT id_plat FROM plat WHERE nom = 'Mi sao'), 1),
    (2, (SELECT id_plat FROM plat WHERE nom = 'Soupe chinoise'), 1),
    (2, (SELECT id_plat FROM plat WHERE nom = 'Ranon''ampango'), 1);

-- Commande 3 : 2 Mofo gasy + 1 Akoho sy voanio
INSERT INTO ligne_commande (id_commande, id_plat, quantite) VALUES
    (3, (SELECT id_plat FROM plat WHERE nom = 'Mofo gasy (les 4)'), 2),
    (3, (SELECT id_plat FROM plat WHERE nom = 'Akoho sy voanio'), 1);

-- Commande 4 : 1 Ravitoto sy henakisoa + 2 Ranon'ampango
INSERT INTO ligne_commande (id_commande, id_plat, quantite) VALUES
    (4, (SELECT id_plat FROM plat WHERE nom = 'Ravitoto sy henakisoa'), 1),
    (4, (SELECT id_plat FROM plat WHERE nom = 'Ranon''ampango'), 2);