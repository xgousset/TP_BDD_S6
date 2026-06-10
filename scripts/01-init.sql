DROP TABLE IF EXISTS avoir_note;
DROP TABLE IF EXISTS evaluation;
DROP TABLE IF EXISTS etudiant;
DROP TABLE IF EXISTS matiere;


CREATE TABLE matiere (
 id_matiere INT,
 code_matière varchar(128),
 intitule varchar(128),
 primary key (id_matiere)
);

CREATE TABLE etudiant (
  id_etudiant INT,
  numero_etudiant INT,
  prenom VARCHAR(128),
  nom VARCHAR(128),
  email VARCHAR(128),
  primary key (id_etudiant)
);


CREATE TABLE evaluation (
    id_evaluation INT,
    titre VARCHAR(128),
    date_eval DATE,
    coefficient DECIMAL(15,2),
    id_matiere INT NOT NULL,
    primary key (id_evaluation),
    foreign key (id_matiere) references matiere(id_matiere)
);




CREATE TABLE avoir_note(
   id_etudiant INT,
   id_evaluation INT,
   valeur INT,
   PRIMARY KEY (id_evaluation,id_etudiant),
   foreign key (id_etudiant) references etudiant(id_etudiant),
   foreign key (id_evaluation) references evaluation(id_evaluation)
);

CREATE USER admin_user WITH PASSWORD 'admin_password';
GRANT ALL PRIVILEGES ON DATABASE multi_lang TO admin_user;
ALTER USER admin_user WITH SUPERUSER; 

ALTER USER root WITH SUPERUSER;

CREATE USER read_only_user WITH PASSWORD 'read_only_password';
GRANT CONNECT ON DATABASE multi_lang TO read_only_user;
GRANT USAGE ON SCHEMA public TO read_only_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_only_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO read_only_user;



---insertions de données