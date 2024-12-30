FROM python:3.9 

RUN useradd -m appuser && \
    mkdir /app && \
    chown -R appuser:appuser /app && \
    pip install beautifulsoup4 python-dotenv requests pytest pytest-cov  # Instalar pytest e pytest-cov

WORKDIR /app

COPY app.py .

EXPOSE 8080

USER appuser

CMD ["python", "./app.py"]