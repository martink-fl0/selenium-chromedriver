from fastapi import FastAPI
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import chromedriver_autoinstaller

chromedriver_autoinstaller.install()

# Create ChromeOptions object to configure headless mode
chrome_options = Options()
chrome_options.add_argument("--headless=new")
chrome_options.binary_location = "/usr/bin/google-chrome"
driver = webdriver.Chrome()
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