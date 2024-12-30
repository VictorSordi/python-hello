# test_app.py
import platform
from io import StringIO
import sys
import pytest

# Importando a função do app.py para testar
from app import os_name, architecture


def test_os_name():
    # Verificar se o nome do sistema operacional está correto
    assert os_name == platform.system()


def test_architecture():
    # Verificar se a arquitetura está correta
    assert architecture == platform.architecture()


def test_output():
    # Teste se a saída está correta
    captured_output = StringIO()
    sys.stdout = captured_output
    print(f"Hello World! from {os_name} operating system on {
          architecture[0]} {architecture[1]} architecture")
    sys.stdout = sys.__stdout__

    expected_output = f"Hello World! from {os_name} operating system on {
        architecture[0]} {architecture[1]} architecture\n"
    assert captured_output.getvalue() == expected_output
