from calculator import addition, multiplication


def test_addition():
    total = addition(4, 5)
    assert total == 9


def test_multiplication():
    total = multiplication(4, 5)
    assert total == 20
