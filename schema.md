# Schéma relationnel : la gargote de Rado

## Étape 01 : La carte

PLAT(**id_plat**, nom, prix) (nouveau)

**Piège :** Le prix est un `INTEGER` car les montants sont en ariary sans centimes,
 on évite les types flottants qui donnent des erreurs d'arrondissement  
 L'identifiant est un numéro technique auto-généré (`id_plat`) plutôt que le nom du plat,
satria ny nom ray peut changer ou être dupliqué nefa ny clé primaire ts maints mijanona unique sy stable.


## Étape 02 : Les catégories

CATEGORIE(**id_categorie**, nom) (nouveau)
PLAT(**id_plat**, nom, prix, #id_categorie) (modifié)

**Piège :** Une colonne `categorie VARCHAR(50)` dans `plat` permet les incohérences d'écriture (« Boisson »,
 « boisson », « Boissons » comptées comme trois catégories), oblige à modifier chaque plat pour renommer une catégorie,
et empêche d'avoir une catégorie sans plat. Une table `categorie` liée par clé étrangère évite tout cela.


## Étape 03 : Les commandes

COMMANDE(**id_commande**, date_commande) (nouveau)
LIGNE_COMMANDE(**#id_commande**, **#id_plat**, quantite) (nouveau)

**Piège :** La quantité se place dans `LIGNE_COMMANDE`, car elle dépend à la fois de la commande et du plat :
 zanh oe nombre d'exemplaires anle plat amle commande. La mettre dans `COMMANDE` ou dans `PLAT` serait impossible,
  puisqu'une commande contient plusieurs plats et qu'un plat figure dans plusieurs commandes.

## Étape 04 : Les habitués

CLIENT(**id_client**, nom) (nouveau)
COMMANDE(**id_commande**, date_commande, #id_client?) (modifié)

**Piège :** La clé étrangère `id_client` n'est pas `NOT NULL` : les clients de passage
 n'ont pas de fiche, donc leur commande n'a pas de client.
 Pour ne perdre aucune commande dans la liste, il faut un `LEFT JOIN` depuis `COMMANDE` ;
  un `INNER JOIN` éliminerait toutes les commandes sans client.

  ## Étape 05 : Serveurs et tables

- CATEGORIE(**id_categorie**, nom)
- PLAT(**id_plat**, nom, prix, #id_categorie)
- CLIENT(**id_client**, nom)
- SERVEUR(**id_serveur**, nom) (nouveau)
- TABLE_SALLE(**id_table_salle**, numero) (nouveau)
- COMMANDE(**id_commande**, date_commande, #id_client?, #id_serveur, #id_table_salle?) (modifié)
- LIGNE_COMMANDE(**#id_commande**, **#id_plat**, quantite)

**Piège :** Une table de la salle est un objet physique et durable qui reçoit plusieurs commandes au fil du temps,
alors qu'une commande est un événement ponctuel (date, plats) : les fusionner répéterait les données de la table à chaque commande.
Le mot `table` est un mot réservé du SQL (`CREATE TABLE`), donc on ne peut pas nommer ainsi une table sans guillemets ; on choisit un autre nom,
qui est `table_salle`.