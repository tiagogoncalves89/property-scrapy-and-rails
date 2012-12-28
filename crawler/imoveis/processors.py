import re
from datetime import date

class ParseCreci(object):

  def __call__(self, valores):
    creci = None
    for valor in valores:
      if valor:
        creci = valor
        break

    if creci:
      valor = re.search('([0-9a-zA-Z]+)$', creci)
      if valor:
        return valor.group(1)

    return creci


class ParseIntegerStart(object):

  def __call__(self, valores):
    integer = None
    for valor in valores:
      if valor:
        integer = valor
        break

    if integer:
      valor = re.search('^([0-9]+)', integer)
      if valor:
        return valor.group(1)

    return integer


class ParseDecimalEnd(object):

  def __call__(self, valores):
    decimal = None
    if valores[0]:
      valor = re.search('([0-9\.,]+)$', valores[0])
      if valor:
        valor = valor.group(1)
        valor = valor.replace('.', '').replace(',', '.')
        return valor
    
    return decimal


class ParseDate(object):

  def __call__(self, valores):
    data = None
    for valor in valores:
      if valor:
        data = valor
        break

    if data:
      valor = re.search('([0-9/]+)$', data)
      if valor:
        valor = valor.group(1)
        valor = valor.split('/')
        valor = date(int(valor[2]), int(valor[1]), int(valor[0]))
        return valor

    return data