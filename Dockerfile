FROM python:3.8

COPY deploy/ /deploy
WORKDIR /deploy

RUN pip install -r requirements.txt 

EXPOSE 3112

CMD ["python", "app.py", "--host=0.0.0.0"]
