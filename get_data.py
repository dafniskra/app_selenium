from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service
import time
from bs4 import BeautifulSoup


def get_website_content(driver):
    try:
        time.sleep(3)
        html_doc = driver.page_source
        driver.quit()

        soup = BeautifulSoup(html_doc, 'lxml')

        try:
            ER = soup.find_all('div', {'class': '_cardValue_1cc1c_150'})[0].get_text().replace('Engagement rate ✨ ','').split('%')[0]
            ER = float(ER.replace(',', '.'))

        except:
            ER = 0.0

        try:
            fol = soup.find_all('div', {'class': '_cardValue_1cc1c_150'})[1].get_text().replace('Followers ', '')
        except:
            fol = '0k'


        if 'k' in fol:
            fol = int(float(fol.replace('k', '')) * 1000)
        elif 'm' in fol:
            fol = int(float(fol.replace('m', '')) * 1000000)
        else:
            fol = 0

        try:
            pays = soup.find_all('div', {'class': '_influencerDetail_1cc1c_111'})[4].get_text()
        except:
            pays = 'None'

        return ER, fol, pays

    except Exception as e:
        print(f"DEBUG:INIT_DRIVER:ERROR:{e}")

    finally:
        if driver is not None: driver.quit()

    return None