-- ==========================================
-- EXERCICE 1 & SCHEMA NORMALISÉ
-- ==========================================

-- Create tables for BUT3
CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL
);

CREATE TABLE matieres (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) NOT NULL
);

CREATE TABLE notes (
    id SERIAL PRIMARY KEY,
    etudiant_id INT REFERENCES etudiants(id),
    matiere_id INT REFERENCES matieres(id),
    valeur NUMERIC(4,2) CHECK (valeur >= 0 AND valeur <= 20)
);

-- Insert data with accents
INSERT INTO etudiants (nom, prenom) VALUES
('Édouard', 'Léa'),
('Àlvarez', 'José'),
('Céline', 'René'),
('Zola', 'Émile');

INSERT INTO matieres (libelle) VALUES ('Bases de Données'), ('Programmation');

INSERT INTO notes (etudiant_id, matiere_id, valeur) VALUES
(1, 1, 15.5),
(2, 1, 18.0),
(3, 2, 12.0);

-- Demonstration of sorting with accents (can be tested later in console)
-- SELECT * FROM etudiants ORDER BY nom COLLATE "fr_FR.utf8";

-- ==========================================
-- EXERCICE 2 : GESTION DES UTILISATEURS
-- ==========================================

CREATE ROLE admin_user WITH LOGIN SUPERUSER PASSWORD 'AdminPass123!';
CREATE ROLE readonly_user WITH LOGIN PASSWORD 'ReadPass123!';

-- ==========================================
-- EXERCICE 3 : ATTRIBUTION DES PRIVILÈGES
-- ==========================================

-- Ensure readonly_user can connect and use the public schema
GRANT CONNECT ON DATABASE multi_lang TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;

-- Grant SELECT ONLY on the Notes table
GRANT SELECT ON notes TO readonly_user;

-- Verify strictness: explicitly revoke all other access on other tables just in case
REVOKE ALL ON etudiants FROM readonly_user;
REVOKE ALL ON matieres FROM readonly_user;