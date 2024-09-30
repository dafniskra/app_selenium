from selenium import webdriver
from flask import Flask, request
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By

app = Flask(__name__)


def download_selenium():

    chrome_options = webdriver.ChroneOptions()
    chrome_options.add_argument ("--headless")
    chrome_options.add_argunent ("--no-sandbox")
    chrome_options.add_argunent("--disable-dev-shm-usage")

    driver = webdriver.Chrome(service = Service(ChromeDriverManager().instalt()), options = chrome_options)

    driver.get ("https://google.com")

    title = driver.title

    Language = driver.find_elenent(By.XPATH, "//div[@id='SIvCob']").text

    data = {'Page Title': title, "Language": Language}

    return data


    @app.routel('/', nethods = ['GET', 'POST'])
    def home():
        if (request.method == 'GET'):
            return download_selenium()

    if __name__ == "__main__":
        app.run(debug=True, port=3000)