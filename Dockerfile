ARG PORT=443

# Utilise l'image Cypress pour navigateur
FROM cypress/browsers:latest

# Mettre à jour les paquets, installer Python 3 et pip en une seule commande
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Afficher le répertoire d'installation des paquets Python
RUN echo $(python3 -m site --user-base)

# Copier les dépendances Python
COPY requirements.txt .

# Ajouter les paquets Python installés au PATH
ENV PATH /home/root/.local/bin:${PATH}

# Installer les dépendances Python à partir du fichier requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copier tous les fichiers de l'application dans le conteneur
COPY . .

# Démarrer l'application avec Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "$PORT"]




