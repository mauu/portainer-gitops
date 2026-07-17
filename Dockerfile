FROM python:3.11-slim

COPY deploy/ /deploy
WORKDIR /deploy

RUN pip install --upgrade pip && pip install -r requirements.txt

EXPOSE 3112

CMD ["python", "app.py", "--host=0.0.0.0"]
