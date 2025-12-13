-- Création de la base si elle n'existe pas
CREATE DATABASE IF NOT EXISTS symfony_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE symfony_db;

-- Table des recettes
CREATE TABLE IF NOT EXISTS recette (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    description TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des ingrédients
CREATE TABLE IF NOT EXISTS ingredient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    unite VARCHAR(50),
    quantite DECIMAL(10,2)
);

-- Table de liaison recette <-> ingrédients (relation N-N)
CREATE TABLE IF NOT EXISTS recette_ingredient (
    recette_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    PRIMARY KEY (recette_id, ingredient_id),
    FOREIGN KEY (recette_id) REFERENCES recette(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(id) ON DELETE CASCADE
);

-- Exemple de données : menus
INSERT INTO recette (titre, description) VALUES
('Poulet au fromage', 'Recette savoureuse de poulet gratiné au fromage'),
('Salade fraîcheur', 'Salade légère avec légumes de saison'),
('Spaghetti bolognaise', 'Pâtes avec sauce tomate et viande hachée'),
('Soupe de légumes', 'Soupe chaude et nourrissante'),
('Tarte aux pommes', 'Dessert classique avec pommes caramélisées');

INSERT INTO ingredient (nom, unite, quantite) VALUES
('Poulet', 'kg', 1.5),
('Fromage', 'g', 200),
('Tomate', 'pièce', 3),
('Laitue', 'pièce', 1),
('Spaghetti', 'g', 500),
('Viande hachée', 'g', 300),
('Carotte', 'pièce', 2),
('Pomme de terre', 'pièce', 2),
('Courgette', 'pièce', 1),
('Pomme', 'pièce', 4),
('Sucre', 'g', 100),
('Pâte brisée', 'pièce', 1);

-- Liaison recettes <-> ingrédients
INSERT INTO recette_ingredient (recette_id, ingredient_id) VALUES
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
