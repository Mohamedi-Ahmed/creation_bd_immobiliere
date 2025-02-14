CREATE DATABASE IF NOT EXISTS dataimmo;
USE dataimmo;

CREATE TABLE region (
    id_region INT PRIMARY KEY AUTO_INCREMENT,
    nom_region VARCHAR(100) NOT NULL
);

CREATE TABLE commune (
    id_commune INT PRIMARY KEY,
    id_region INT,
    code_departement VARCHAR(3),
    nom_commune VARCHAR(255),
    FOREIGN KEY (id_region) REFERENCES region(id_region)
);

CREATE TABLE bien (
    id_bien INT AUTO_INCREMENT PRIMARY KEY,
    no_voie VARCHAR(10),
    type_voie VARCHAR(10),
    voie VARCHAR(255),
    total_piece INT,
    surface_carrez FLOAT,
    surface_local FLOAT,
    type_local VARCHAR(50),
    id_commune INT,
    FOREIGN KEY (id_commune) REFERENCES commune(id_commune)
);

CREATE TABLE vente (
    id_vente INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    valeur FLOAT,
    id_bien INT,
    FOREIGN KEY (id_bien) REFERENCES bien(id_bien)
);

CREATE TABLE population (
    id_population INT AUTO_INCREMENT PRIMARY KEY,
    id_commune INT,
    annee INT,
    population FLOAT,
    FOREIGN KEY (id_commune) REFERENCES commune(id_commune)
);
