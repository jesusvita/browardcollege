from django.db import models

class tipOut(models.Model):
    teppan = models.CharField(max_length=140, default='')
    sushi = models.CharField(max_length=140, default='')
    bar = models.CharField(max_length=140, default='')
    busser = models.CharField(max_length=140, default='')

    def __str__(self):
        return str(self.id)
