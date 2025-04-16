# Projet d'Automatisation avec Robot Framework

## Auteurs
Ce projet a été réalisé par :
- Enzo TESSIER
- Tom BURY
- Louis DENIS

## Description
Ce projet utilise **Robot Framework** pour automatiser des cas de test end-to-end. Il inclut des tests pour la gestion des employés dans l'application OrangeHRM, tels que la modification des détails d'un employé et la suppression d'un employé.

## Fonctionnalités
- **Tests End-to-End** : Automatisation des workflows clés dans l'application OrangeHRM.
- **Mots-clés Réutilisables** : Des mots-clés modulaires et dynamiques pour une meilleure réutilisation du code.
- **Syntaxe Gherkin** : Cas de test écrits dans un format BDD pour une meilleure lisibilité et maintenabilité.

## Ordre d'Exécution des Tests

Pour garantir le bon fonctionnement et une logique cohérente, exécutez les tests dans l'ordre suivant :

1. **Ajout d'un employé** : Ajoute un nouvel employé dans le système. C'est le point de départ pour tous les tests suivants.
2. **Test d'un Utilisateur** : Crée un utilisateur associé à l'employé ajouté.
3. **Recherche d'un utilisateur** : Vérifie que l'utilisateur peut être recherché et récupéré avec succès.
4. **Modification d'un employé** : Met à jour les détails de l'employé ajouté.
5. **Suppression d'un employé** : Supprime l'employé pour nettoyer les données.

Suivez cet ordre pour éviter les problèmes de dépendance et assurer une exécution fluide de la suite de tests.


## Prérequis
- Python (version 3.7 ou supérieure)
- Robot Framework
- SeleniumLibrary
- ChromeDriver (compatible avec votre version de Chrome)


## Spécificité
Pour la création d'un utilisateur, on utilise l’employé nommé Enzo Tessier.
S’il n’existe plus, il faut le recréer afin d’éviter d’altérer les tests des autres utilisateurs.
Pour garantir qu’un employé soit toujours disponible, on peut remplacer la variable name par "a" : cela permettra de sélectionner automatiquement le premier employé dont le nom commence par "a".


## Installation
1. Clonez le dépôt :
   ```bash
   git clone <url-du-repository>
   cd <dossier-du-repository>
