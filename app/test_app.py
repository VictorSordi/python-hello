import pytest
from io import StringIO
import sys
from app import main


def test_hello_world():
    captured_output = StringIO()
    sys.stdout = captured_output
    main()
    sys.stdout = sys.__stdout__

    expected_output = "Hello World!\n"
    assert captured_output.getvalue() == expected_output
