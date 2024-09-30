ARG PORT=443

# Utilise une image de base Python plus légère
FROM python:3.9-slim

# Installer les dépendances système pour les paquets requis
RUN apt-get update && \
    apt-get install -y wget gnupg2 curl unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Vérifier la version de Python et pip installées
RUN python3 --version && python3 -m pip --version

# Afficher le répertoire d'installation des paquets Python
RUN echo $(python3 -m site --user-base)

# Copier le fichier requirements.txt et afficher son contenu
COPY requirements.txt .
RUN cat requirements.txt

# Installer les dépendances Python à partir de requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copier tous les fichiers de l'application dans le conteneur
COPY . .

# Démarrer l'application avec Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "${PORT}"]
