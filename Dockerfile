FROM python:3.9 

WORKDIR /app

ADD app.py .

RUN pip install requests beautifulsoup4 python-dotenv

EXPOSE 8080

CMD [“python”, “./app.py”] 