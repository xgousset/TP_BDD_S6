-- Données pour la table matiere
INSERT INTO matiere (id_matiere, code_matière, intitule) VALUES
(1, 'BDD1', 'Bases de données relationnelles'),
(2, 'PROG1', 'Développement Web'),
(3, 'SYS1', 'Systèmes et Réseaux');

-- Données pour la table etudiant
INSERT INTO etudiant (id_etudiant, numero_etudiant, prenom, nom, email) VALUES
(1, 222001, 'Alice', 'Dupont', 'alice.dupont@etu.univ.fr'),
(2, 222002, 'Bob', 'Martin', 'bob.martin@etu.univ.fr'),
(3, 222003, 'Charlie', 'Durand', 'charlie.durand@etu.univ.fr');

-- Données pour la table evaluation
INSERT INTO evaluation (id_evaluation, titre, date_eval, coefficient, id_matiere) VALUES
(1, 'Examen Final BDD', '2026-06-15', 2.0, 1),
(2, 'TP Noté Web', '2026-06-10', 1.0, 2),
(3, 'Contrôle Continu Système', '2026-06-12', 1.5, 3);

-- Données pour la table avoir_note
INSERT INTO avoir_note (id_etudiant, id_evaluation, valeur) VALUES
(1, 1, 15),
(1, 2, 18),
(2, 1, 12),
(2, 3, 14),
(3, 2, 16),
(3, 3, 10);
