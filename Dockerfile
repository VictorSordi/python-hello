FROM python:3.9

# Criando um usuário, diretório e instalando as dependências
RUN useradd -m appuser && \
    mkdir /app && \
    chown -R appuser:appuser /app && \
    pip install beautifulsoup4 python-dotenv requests pytest pytest-cov

WORKDIR /app

COPY . .

ENV PYTHONPATH=/app:$PYTHONPATH

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 8080

CMD ["python", "./app.py"]
