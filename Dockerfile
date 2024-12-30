FROM python:3.9

RUN useradd -m appuser && \
    pip install beautifulsoup4 python-dotenv requests pytest pytest-cov

WORKDIR /app

COPY . /app/

RUN pip install pytest pytest-cov

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 8080

CMD ["python", "./app.py"]
