-- 🔐 Forcer l'encodage UTF-8 dès le début
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- Création de la base si elle n'existe pas
CREATE DATABASE IF NOT EXISTS symfony_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE symfony_db;

-- Table des recipes
CREATE TABLE IF NOT EXISTS recipe (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content LONGTEXT,
    duration INT,
    slug VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table des ingrédients
CREATE TABLE IF NOT EXISTS ingredient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    unite VARCHAR(50),
    quantite DECIMAL(10,2),
    slug VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table de liaison recipe <-> ingrédients
CREATE TABLE IF NOT EXISTS recipe_ingredient (
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Exemple de données : menus
INSERT INTO recipe (title, content, duration,slug) VALUES
('Poulet au fromage', 'Recette savoureuse de poulet gratiné au fromage',50, 'poulet-fromage'),
('Salade fraîcheur', 'Salade légère avec légumes de saison', 10,'salade-fraicheur'),
('Spaghetti bolognaise', 'Pâtes avec sauce tomate et viande hachée',30, 'spaghetti-bolognaise'),
('Soupe de légumes', 'Soupe chaude et nourrissante',30, 'soupe-legumes'),
('Tarte aux pommes', 'Dessert classique avec pommes caramélisées',20, 'tarte-pommes');

INSERT INTO ingredient (nom, unite, quantite, slug) VALUES
('Poulet', 'kg', 1.5, 'poulet'),
('Fromage', 'g', 200, 'fromage'),
('Tomate', 'pièce', 3, 'tomate'),
('Laitue', 'pièce', 1, 'laitue'),
('Spaghetti', 'g', 500, 'spaghetti'),
('Viande hachée', 'g', 300, 'viande-hachee'),
('Carotte', 'pièce', 2, 'carotte'),
('Pomme de terre', 'pièce', 2, 'pomme-de-terre'),
('Courgette', 'pièce', 1, 'courgette'),
('Pomme', 'pièce', 4, 'pomme'),
('Sucre', 'g', 100, 'sucre'),
('Pâte brisée', 'pièce', 1, 'pate-brisee');

-- Liaisons
INSERT INTO recipe_ingredient (recipe_id, ingredient_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(3, 3),
(4, 7),
(4, 8),
(4, 9),
(5, 10),
(5, 11),
(5, 12);
