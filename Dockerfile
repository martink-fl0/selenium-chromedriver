FROM  selenium/standalone-chrome:latest

WORKDIR /code

USER root
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip3 install --no-cache-dir --upgrade -r requirements.txt

COPY . .

USER seluser

CMD ["uvicorn", "main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8080"]