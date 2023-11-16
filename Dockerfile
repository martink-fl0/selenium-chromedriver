# FROM python:3.9 as requirements-stage
# WORKDIR /tmp
# RUN pip install poetry
# COPY ./pyproject.toml ./poetry.lock* /tmp/
# RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

FROM python:3.11

# RUN  apt-get update \
#   && apt-get install -y wget unzip \
#   && rm -rf /var/lib/apt/lists/*

# RUN apt-get update \ 
#   && apt-get install -y libglib2.0-0 \
#   libnss3 \
#   libgconf-2-4 \
#   libfontconfig1 \
#   libxcb1

# install chrome directly
# RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# RUN dpkg -i google-chrome-stable_current_amd64.deb --fix-missing; apt-get -fy install

# install chromedriver
# RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip
# RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

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

# RUN apt-get update && apt-get install gnupg wget -y && \
#   wget --quiet --output-document=- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg && \
#   sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
#   apt-get update && \
#   apt-get install google-chrome-stable -y && \
#   rm -rf /var/lib/apt/lists/*

# Copy the rest of the application code
COPY . .

CMD ["uvicorn", "main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8080"]