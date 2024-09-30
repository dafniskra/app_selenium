ARG PORT=443
FROM cypress/browsers:latest

# Mettez à jour et installez Python et pip en une seule commande
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

# Affiche l'emplacement des paquets Python installés
RUN echo $(python3 -m site --user-base)

# Copie le fichier requirements.txt
COPY requirements.txt .

# Ajoute les paquets pip dans le PATH
ENV PATH /home/root/.local/bin:${PATH}

# Installe les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Copie le reste des fichiers dans l'image
COPY . .

# Commande de démarrage
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "$PORT"]
