from selenium import webdriver
from flask import Flask, request
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from get_data import get_website_content
app = Flask(__name__)

def download_selenium(account):

    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")

    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()),
                              options=chrome_options)

    driver.get("https://www.modash.io/engagement-rate-calculator?influencer=%40" + str(account))

    ER, fol, pays = get_website_content(driver)

    data = {'ER': ER, 'fol': fol, 'pays': pays}

    return data


@app.route('/<query>', methods = ['GET', 'POST'])
def home(query):
    if request.method == 'GET':
        print(f"Résultats pour la recherche: {query}")
        return download_selenium(query)

if __name__ == "__main__":
    app.run(debug=True, port=3000)