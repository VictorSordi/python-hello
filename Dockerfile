FROM python:3.9 

WORKDIR /app

COPY app.py .

RUN pip install beautifulsoup4 python-dotenv requests

EXPOSE 8080

CMD ["python", "./app.py"]
