# INote
Projet soutenance CDA Diginamic 2023

# Cahier des charges pour l'application INote

**1. Introduction**

1\.1 Objectif

<a name="_hlk148000353"></a>Le projet vise à développer une application de gestion, d’indexation, de classification et de référencement des notes pour les particuliers. Cette application doit offrir une solution conviviale et efficace pour les utilisateurs.

**1.2 Contexte**

**1.3 Portée**

Cette application doit permettre :

- A un utilisateur de s’inscrire et de s’authentifier
- A un utilisateur de créer, modifier, supprimer un tableau
- A un utilisateur de partager un tableau existant.
- A un utilisateur de créer, modifier supprimer une note
- A un utilisateur d’importer un PDF pour automatiser la création d’une note
- A un utilisateur de partager une note existante.
- A un utilisateur de faire une recherche dans le moteur de recherche de l’application pour retrouver facilement ses propres notes et celles des tableaux auxquels il est abonné.
- A un Administrateur créer, modifier, supprimer un utilisateur
- A un Administrateur de créer, modifier, supprimer un rôle

**1.4 Vocabulaire**

- Un Utilisateur inscrit peut utiliser l’application 
- Un Administrateur gère les utilisateurs et les rôles

**2 Objectifs et résultats attendus**

**2.1 Objectifs**

<a name="_hlk148000409"></a>Les objectifs de l'application INotes sont les suivants :

- Offrir une interface conviviale et intuitive pour les utilisateurs, facilitant l’indexation de leurs notes.
- Permettre aux utilisateurs de référencer et d'organiser leurs notes de manière efficace.
- Fournir une fonctionnalité de recherche avancée pour retrouver rapidement des notes spécifiques.
- Faciliter la collaboration entre les utilisateurs en permettant le partage des notes et des tableaux.
- Améliorer l'expérience d'apprentissage en fournissant des fonctionnalités telles que la sauvegarde de notes et tableaux favoris.
- Assurer la sécurité des données des utilisateurs en mettant en place des mesures de protection des données sensibles.

**2.2 Résultats attendus**

Les résultats attendus de l'application INotes comprennent :

- Une application mobile (iOS et Android) et une version web fonctionnelles et conviviales.
- Un système d'authentification sécurisé et une gestion de compte pour les utilisateurs.
- La possibilité pour les utilisateurs de créer, organiser, éditer et supprimer des notes.
- Une fonction de recherche permettant de trouver rapidement des notes en fonction de différents critères.
- La possibilité de partager des notes et des tableaux avec d'autres utilisateurs.
- Un panneau d'administration pour la gestion des utilisateurs et des paramètres, et des rôles de l'application.
- Une base de données sécurisée pour stocker les informations des utilisateurs.


**3. Description fonctionnelle**

**3.1 Authentification**

Écran d'authentification avec authentification (e-mail, mot de passe). Écran de réinitialisation de mot de passe avec envoi d'e-mail. Une connexion requiert les informations suivantes :

- Email
- Mot de passe

**3.2 Mot de passe perdu**

L’utilisateur peut à tout moment demander la réinitialisation de son mot passe. Cette demande requiert les informations suivantes : 

- Email

**3.3 Inscription**

Enregistrement des utilisateurs.

Collecte d'informations de base pour les utilisateurs

:

- Email
- Mot de passe

Le reste des informations peuvent être renseignées ultérieurement :

- Prénom
- Nom
- téléphone
- Job
- Avatar
- Biographie

**3.4 Gestion des tableaux**

Les utilisateurs peuvent effectuer les actions suivantes concernant la gestion des tableaux :

- Créer, modifier, supprimer un tableau
- Partager un tableau existant
- Rejoindre un tableau existant

La création/Modification d’une équipe requiert les informations suivantes :

- Nom

**3.5 Gestion des catégories**

Les utilisateurs peuvent effectuer les actions suivantes concernant la gestion des catégories de note :

- Créer, modifier, supprimer une catégorie

La création/Modification d’une catégorie requiert les informations suivantes :

- Nom


**3.6 Gestion des notes**

Les utilisateurs peuvent effectuer les actions suivantes concernant la gestion de leurs notes :

- Créer une note
- Importer un PDF pour la création automatique d’une note
- Modifier une note existante.
- Supprimer une note.
- Ajouter des notes, des fichiers ou des liens de référence pertinents à une note.
- Partager une note
- Rechercher une note
- Affecter une note à un tableau existant

La création/Modification d’une note requiert les informations suivantes :

- Titre
- Description
- Catégorie
- Contenu
- Image
- Document
- Catégorie
- Tableau
- Utilisateur
- Date de publication


**3.7 Partage de tableau et de note**

Les utilisateurs peuvent partager des tableaux et des notes spécifiques avec d'autres utilisateurs en utilisant une fonction de partage sécurisée cependant les utilisateurs appartenant à une même équipe reçoivent un email quand une nouvelle note est créée.

L’utilisateur qui reçoit le lien de partage doit être inscrit et authentifié pour voir le tableau ou la note. 

**Règles métier :**

- L’email et le mot de passe sont obligatoires pour créer un compte.
- Aucune fonctionnalité n’est utilisable si l’utilisateur n’est pas inscrit et authentifié.
- L’utilisateur peut affecter une note à une ou plusieurs catégories.
- L’utilisateur peut appartenir à un ou plusieurs tableau(x) existant(s).
- L’utilisateur ne peut modifier ou supprimer que ses propres notes et tableaux
- Les tableaux sont une liste de note.
- La création d’un tableau ou l’adhésion à un tableau est obligatoire pour créer une note.
- La création d’un tableau ou l’adhésion à un tableau est obligatoire pour créer ou partager une note, partager un tableau.
- L’utilisateur peut créer une note en la rédigeant lui-même ou importer un PDF et l’application génère automatiquement la note mise en forme avec les titres et les images adéquates. 
- Une fois la note créée l’utilisateur peut effectuer une recherche dans le moteur de recherche en tapant un mot clé ou une phrase ainsi il retrouvera facilement les notes qui l’intéresse et qui correspondent à sa recherche. 
- L’étendue de la recherche est limitée aux notes créées par l’utilisateur ou par les abonnés au tableau.

**3.8 Administration**

En tant qu’administrateur je peux effectuer les actions suivantes :

- Créer, modifier, supprimer un utilisateur
- Créer, modifier, supprimer un rôle

La création/Modification d’un rôle requiert les informations suivantes :

- nom

**3.9 Enregistrement automatique**

Le système enregistre automatique un brouillon de chaque note lors de la création ou de la modification et ceci tant que l’utilisateur n’a pas cliquer sur « Publier la note ».

**4. Contraintes techniques**

**4.1 Protection des données**

L'application doit être conforme aux lois sur la protection des données (telles que le RGPD en Europe) et doit garantir la confidentialité des données personnelles des utilisateurs. Les données sensibles doivent être stockées de manière sécurisée et ne doivent être accessibles qu'aux utilisateurs autorisés.


**4.1 Plateformes**

L'application doit être disponible sur les plateformes suivantes :

iOS (iPhone et iPad).

Android (smartphones et tablettes).

Application web compatible avec les principaux navigateurs.

**4.2 Technologies**

Langages de programmation : Java, Spring Boot, ORM.

Base de données : MySql.

Frameworks : Java (backend), Angular (frontend), Ionic Capacitor

**4.3 Sécurité**

Authentification sécurisée.

Chiffrement des données sensibles.

Protection contre les failles de sécurité.

**5. Contraintes de développement**

**5.1 Conformité aux réglementations**

L'application doit respecter toutes les réglementations locales et internationales applicables en matière de sécurité des données, de confidentialité et de droits des utilisateurs.

**6. Calendrier et étapes de développement**

Établissement d'un calendrier préliminaire avec des étapes clés pour le développement de l'application.

**6.1 Étapes clés**

- Conception de l'interface utilisateur et des fonctionnalités.
- Développement de la version bêta de l'application.
- Tests de l'application pour assurer la stabilité et la sécurité.
- Lancement de la version finale de l'application.
- Suivi et maintenance continue de l'application.


**7. Budget**

Établissement d'un budget estimatif pour le développement de l'application, en incluant les coûts de développement, de maintenance, de marketing, etc.

- Coûts de développement logiciel (développeurs, designers, etc.).
- Coûts de serveurs et d'hébergement.
- Coûts liés à la sécurité des données.
- Coûts de marketing et de promotion.

**8. Modalités de collaboration**

Définition des modalités de collaboration avec les développeurs, les designers, les gestionnaires de projet, etc.

**9. Références**

Liste de la documentation de référence, des spécifications techniques détaillées et des modèles de contrat, le cas échéant.
