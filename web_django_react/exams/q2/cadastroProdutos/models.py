from django.db import models


class Cadastro(models.Model):
    name = models.CharField(max_length=200)
    quantity = models.IntegerField()

    def __str__(self):
        return f'{self.name}. {self.quantity}'