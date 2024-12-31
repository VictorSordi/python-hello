FROM python:3.9

RUN useradd -m appuser && \
    mkdir /app && \
    chown -R appuser:appuser /app && \
    pip install --no-cache-dir beautifulsoup4 pytest pytest-cov python-dotenv requests

WORKDIR /app

COPY . .

RUN chown -R appuser:appuser .

USER appuser

EXPOSE 8080

CMD ["python", "./app.py"]
