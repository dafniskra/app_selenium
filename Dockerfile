ARG PORT=443

# Utilise l'image Cypress pour navigateur
FROM cypress/browsers:latest

# Mettre à jour les paquets, installer Python 3 et pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Vérifier la version de Python et pip installées
RUN python3 --version && python3 -m pip --version

# Afficher le répertoire d'installation des paquets Python
RUN echo $(python3 -m site --user-base)

# Copier le fichier requirements.txt et afficher son contenu pour vérifier qu'il a bien été copié
COPY requirements.txt .
RUN cat requirements.txt

# Ajouter les paquets Python installés au PATH
ENV PATH /home/root/.local/bin:${PATH}

# Mettre à jour pip en utilisant 'python3 -m pip'
RUN python3 -m pip install --upgrade pip

# Installer les dépendances une par une pour voir quelle installation échoue
RUN python3 -m pip install --no-cache-dir selenium
RUN python3 -m pip install --no-cache-dir flask
RUN python3 -m pip install --no-cache-dir requests==2.28.1
RUN python3 -m pip install --no-cache-dir webdriver-manager
RUN python3 -m pip install --no-cache-dir packaging==21.3
RUN python3 -m pip install --no-cache-dir flask-restful==0.3.9
RUN python3 -m pip install --no-cache-dir gunicorn==20.1.0
RUN python3 -m pip install --no-cache-dir beautifulsoup4
RUN python3 -m pip install --no-cache-dir lxml

# Copier tous les fichiers de l'application dans le conteneur
COPY . .

# Démarrer l'application avec Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "$PORT"]
