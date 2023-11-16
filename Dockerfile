# FROM python:3.9 as requirements-stage
# WORKDIR /tmp
# RUN pip install poetry
# COPY ./pyproject.toml ./poetry.lock* /tmp/
# RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

FROM python:3.11

# Install dependencies
RUN apt-get update && apt-get install -y wget unzip

# Download and install chromedriver
RUN wget https://chromedriver.storage.googleapis.com/<VERSION>/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip -d /usr/local/bin/
RUN rm chromedriver_linux64.zip

WORKDIR /code

COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Install wget and Google Chrome
# RUN apt-get update && apt-get install -y wget \
#     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#     && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
#     && apt-get update \
#     && apt-get -y install google-chrome-stable

# Copy the rest of the application code
COPY . .

CMD ["uvicorn", "main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8080"]