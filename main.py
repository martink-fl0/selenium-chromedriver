from fastapi import FastAPI
from selenium.webdriver.chrome.options import Options
from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.core.os_manager import ChromeType

# Create ChromeOptions object to configure headless mode
# options = webdriver.ChromeOptions()
# options.add_argument('--no-sandbox')
# options.add_argument('--headless=new')
# options.binary_location = "/usr/bin/google-chrome"

# driver = webdriver.Chrome(options=options)
driver = webdriver.Chrome(service=ChromiumService(ChromeDriverManager(chrome_type=ChromeType.CHROMIUM).install()))

# chrome_options = Options()
# chrome_options.add_argument("--headless=new")
# chrome_options.binary_location = "/usr/bin/google-chrome"
# driver = webdriver.Chrome()
app = FastAPI()
with open("test.txt", 'w') as f:
    f.write("")
@app.get("/")
async def root():
    return {"message": "Hello World"}
@app.get("/write/{text}")
async def root1(text):
    with open("test.txt", 'w') as f:
        f.write(text)
    return {"message": text}
@app.get("/read")
async def root2():
    with open("test.txt", 'r') as f:
        content = f.read()
    return {"message": content}
# Persistent Disk Test?