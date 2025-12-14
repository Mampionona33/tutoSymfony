-- Création de la base si elle n'existe pas
CREATE DATABASE IF NOT EXISTS symfony_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE symfony_db;

-- Table des recipes
CREATE TABLE IF NOT EXISTS recipe (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
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

-- Table de liaison recipe <-> ingrédients (relation N-N)
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
INSERT INTO recipe (title, content, slug) VALUES
('Poulet au fromage', 'Recette savoureuse de poulet gratiné au fromage', 'poulet-fromage'),
('Salade fraîcheur', 'Salade légère avec légumes de saison', 'salade-fraicheur'),
('Spaghetti bolognaise', 'Pâtes avec sauce tomate et viande hachée', 'spaghetti-bolognaise'),
('Soupe de légumes', 'Soupe chaude et nourrissante', 'soupe-legumes'),
('Tarte aux pommes', 'Dessert classique avec pommes caramélisées', 'tarte-pommes');

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

-- Liaison recipes <-> ingrédients
INSERT INTO recipe_ingredient (recipe_id, ingredient_id) VALUES
(1, 1), -- Poulet au fromage contient Poulet
(1, 2), -- Poulet au fromage contient Fromage
(2, 3), -- Salade fraîcheur contient Tomate
(2, 4), -- Salade fraîcheur contient Laitue
(3, 5), -- Spaghetti bolognaise contient Spaghetti
(3, 6), -- Spaghetti bolognaise contient Viande hachée
(3, 3), -- Spaghetti bolognaise contient Tomate
(4, 7), -- Soupe de légumes contient Carotte
(4, 8), -- Soupe de légumes contient Pomme de terre
(4, 9), -- Soupe de légumes contient Courgette
(5, 10), -- Tarte aux pommes contient Pomme
(5, 11), -- Tarte aux pommes contient Sucre
(5, 12); -- Tarte aux pommes contient Pâte brisée
