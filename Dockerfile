ARG PORT=443

# Utilise une image de base Python plus légère
FROM python:3.9-slim

# Installer les dépendances système nécessaires
RUN apt-get update && \
    apt-get install -y wget gnupg2 curl unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copier le fichier requirements.txt et installer les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Installer Uvicorn manuellement si ce n'est pas dans requirements.txt
RUN pip install uvicorn

# Copier tous les fichiers de l'application dans le conteneur
COPY . .

# Démarrer l'application sans souci de variable d'environnement dans la commande CMD
CMD ["python3", "webapp.py"]

