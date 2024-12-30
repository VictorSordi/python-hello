FROM python:3.9

RUN useradd -m appuser && \
    mkdir /app && \
    chown -R appuser:appuser /app && \
    pip install --no-cache-dir beautifulsoup4 python-dotenv requests pytest pytest-cov

WORKDIR /app

COPY /app/app.py /app/

COPY /app/test_app.py /app/

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 8080

CMD ["python", "./app.py"]
