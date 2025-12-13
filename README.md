# Base de données MySQL + Adminer

Ce projet utilise Docker pour lancer une base MySQL et l’interface Adminer.

## 🚀 Lancer les services

Depuis la racine du projet, exécute :

```bash
docker compose -f ./docker/db/docker-compose.yml up -d
```

- `-f ./docker/db/docker-compose.yml` → indique le chemin vers ton fichier compose.
- `up -d` → démarre les conteneurs en arrière-plan (mode détaché).

Pour arrêter et supprimer les conteneurs :

```bash
docker compose -f ./docker/db/docker-compose.yml down
```

---

## 🔑 Connexion à Adminer

Une fois les conteneurs lancés, Adminer est accessible via [http://localhost:8080](http://localhost:8080).

Paramètres de connexion :

- **Système** : MySQL
- **Serveur** : `mysql` (nom du service Docker)
- **Utilisateur** : `symfony`
- **Mot de passe** : `symfony`
- **Base de données** : `symfony_db`

> ⚠️ Si vous utilisez l’utilisateur `root`, le mot de passe est `root`.

---

## 🛠 Vérification rapide en ligne de commande

Pour tester la base directement depuis le terminal :

```bash
docker exec -it db-mysql mysql -u symfony -p
```

Puis entrer le mot de passe `symfony`.

Exemples de commandes SQL :

```sql
SHOW DATABASES;
USE symfony_db;
SHOW TABLES;
SELECT * FROM recette;
```
