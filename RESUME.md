# Fiche de Révision : Administration Avancée de Bases de Données & Types de BDD

Ce document est une synthèse des cours "Administration Avancée L3" et "Types de Bases de Données", conçu spécifiquement pour réviser un examen sous forme de QCM.

---

## PARTIE 1 : Administration Avancée PostgreSQL

### 1. Gestion des espaces de données
*   **Objectif :** Optimiser le stockage pour réduire les coûts, éviter la corruption, et améliorer les performances.
*   **Tablespace :** Emplacement sur le système de fichiers pour stocker des données.
    *   *Avantages :* Répartit les fichiers sur plusieurs disques, gère mieux l'espace et les I/O.
    *   *SQL :* `CREATE TABLESPACE mon_espace LOCATION '/chemin';` puis `CREATE DATABASE ... TABLESPACE mon_espace;`.

### 2. Architecture PostgreSQL
*   **Postmaster :** Processus principal de supervision, gère les connexions clientes.
*   **Processus utilitaires :** Bgwriter (Background Writer), Syslogger, Archiver, Autovacuum, WAL sender/receiver.
*   **Backend process :** Un processus serveur `postgres` alloué par connexion utilisateur.

### 3. Gestion des utilisateurs et de la sécurité
*   Les utilisateurs de la BDD sont *séparés* des utilisateurs de l'OS (bien que l'utilisateur `postgres` soit souvent le superutilisateur par défaut).
*   **Niveaux de sécurité :**
    *   **pg_hba.conf :** Gère l'authentification réseau (IP, méthodes : `trust`, `md5`, etc.).
    *   **postgresql.conf :** Configuration globale (ex: `listen_addresses`).
*   **Commandes SQL :** `CREATE USER`, `DROP USER`, `CREATE GROUP`.
*   **Privilèges :** Gérés avec `GRANT` (ex: `GRANT SELECT ON table TO user;`) et `REVOKE`. Le créateur (Owner) a tous les droits par défaut. L'utilisateur `PUBLIC` désigne tous les utilisateurs.
*   **Attributs :** `SUPERUSER` (contourne tout contrôle), `CREATEDB`.

### 4. Backup (Sauvegarde) et Restore (Restauration)
*   **Sauvegarde logique (à chaud) :** Génère un fichier SQL (DUMP).
    *   *Outils :* `pg_dump` (pour une seule BDD) et `pg_dumpall` (pour tout le cluster/toutes les BDD).
*   **Sauvegarde physique (à froid) :** Copie des fichiers système (`File system level backup`).
*   **Restauration :** S'effectue avec l'outil `psql` (ex: `psql dbname < backup.sql`).

### 5. Réplication et WAL (Write-Ahead Log)
*   **WAL (Journal des transactions) :** Fichiers binaires stockant séquentiellement toutes les modifications *avant* qu'elles ne soient écrites dans la table. Assure la réparation en cas de crash. (Segments de 16 Mo dans `pg_xlog`).
*   **Checkpoint :** Point de contrôle où les données modifiées en RAM (Shared Buffers) sont écrites définitivement sur le disque dur. Permet d'optimiser les écritures I/O. (Paramètres clés: `checkpoint_segments`, `checkpoint_timeout`).
*   **Types de réplication :**
    *   **Synchrone :** Le Master attend la confirmation du Slave avant de valider. Garantit 0 perte, mais impacte les performances.
    *   **Asynchrone :** Le Master n'attend pas. Meilleures performances, mais léger décalage (lag) possible (`sync_state = async` dans `pg_stat_replication`).

### 6. Fédération et Internationalisation (i18n)
*   **Fédération :** Traiter des bases de données réparties sur plusieurs serveurs comme une seule entité (répartition de charge, intégration). Utilise l'extension `postgres_fdw`.
*   **i18n :** Gère les langues et formats.
    *   *Encodage :* Principalement UTF-8.
    *   *Collation :* Règles de tri et comparaison (ex: `LC_COLLATE`).
    *   *Extensions utiles :* `pg_trgm` (similarité), `unaccent` (ignore les accents).

---

## PARTIE 2 : Les Différents Types de Bases de Données

### 1. Bases de Données Relationnelles (RDBMS)
*   **Structure :** Tables avec lignes et colonnes.
*   **Standard :** Langage SQL, respecte les propriétés ACID (Atomicité, Cohérence, Isolation, Durabilité).
*   **Exemples :** PostgreSQL, MySQL, Oracle.
*   **Avantages / Inconvénients :** Très forte cohérence et intégrité / Schéma rigide.

### 2. Bases de Données NoSQL (Not Only SQL)
*   **a. Orientée Document :**
    *   Stocke les données en documents JSON ou BSON. Très flexible.
    *   *Exemple :* MongoDB (Idéal pour les produits d'un e-commerce).
*   **b. Clé-Valeur :**
    *   Données très simples. Extrêmement rapide, souvent en RAM.
    *   *Exemple :* Redis (Idéal pour le cache, paniers utilisateurs).
*   **c. Orientée Colonnes :**
    *   Données réparties en colonnes. Très performant en lecture sur de grands volumes.
    *   *Exemple :* Cassandra (Idéal pour le Big Data).
*   **d. Graphe :**
    *   Basée sur des Nœuds et des Relations.
    *   *Exemple :* Neo4j (Parfait pour les réseaux sociaux, recommandations).

### 3. Autres Types
*   **Orientée Objets :** `db4o` (Stocke des instances d'objets POO).
*   **Temporelle (Time-Series) :** `TimescaleDB`, `InfluxDB` (Optimisé pour les événements datés : monitoring, logs).
*   **En Mémoire :** `Memcached`, `Redis` (Rapidité extrême).
*   **Cloud-Native / Distribuée :** `Firebase`, `Aurora`, `Cassandra` (Haute disponibilité, géré par le cloud).

### 4. Critères de choix (Synthèse)
Il n'y a pas de "meilleure" base. Le choix dépend du besoin métier, menant souvent à des architectures hybrides.
*   *E-commerce :* RDBMS (PostgreSQL) pour la facturation/commandes + Document (MongoDB) pour le catalogue produit + Clé-Valeur (Redis) pour le panier.
*   *Réseau social :* Graphe (Neo4j) pour les amis + Document (Couchbase) pour les posts + Temporelle (InfluxDB) pour le monitoring réseau.
