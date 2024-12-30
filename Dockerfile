FROM python:3.9 

RUN useradd -m appuser

WORKDIR /app

COPY app.py .

RUN chown -R appuser:appuser /app

RUN pip install beautifulsoup4 python-dotenv requests

EXPOSE 8080

USER appuser

CMD ["python", "./app.py"]
