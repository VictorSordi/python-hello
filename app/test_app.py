import platform
from io import StringIO
import sys
import pytest

from app import os_name, architecture

def test_os_name():
    assert os_name == platform.system()

def test_architecture():
    assert architecture == platform.architecture()

def test_output():
    captured_output = StringIO()
    sys.stdout = captured_output
    print(f"Hello World! from {os_name} operating system on {architecture[0]} {architecture[1]} architecture")
    sys.stdout = sys.__stdout__

    expected_output = f"Hello World! from {os_name} operating system on {architecture[0]} {architecture[1]} architecture\n"
    assert captured_output.getvalue() == expected_output
