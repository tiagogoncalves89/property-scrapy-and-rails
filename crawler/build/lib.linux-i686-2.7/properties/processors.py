import re
from datetime import date

class ParseDecimal(object):

  def __call__(self, valores):
    if valores[0]:
      return valores[0].replace('.', '').replace(',', '.')


class ParseDate(object):

  def __call__(self, valores):
    if valores[0]:
      valor = valores[0].split('/')
      return date(int(valor[2]), int(valor[1]), int(valor[0]))