# Schéma relationnel : la gargote de Rado

## Étape 01 : La carte

PLAT(**id_plat**, nom, prix) (nouveau)

**Piège :** Le prix est un `INTEGER` car les montants sont en ariary sans centimes,
 on évite les types flottants qui donnent des erreurs d'arrondissement  
 L'identifiant est un numéro technique auto-généré (`id_plat`) plutôt que le nom du plat, satria ny nom ray peut changer ou être dupliqué nefa ny clé primaire ts maints mijanona unique sy stable.
