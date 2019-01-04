from django.db import models

class tipOut(models.Model):
    teppan = models.CharField(max_length=140, default='0')
    sushi = models.CharField(max_length=140, default='0')
    bar = models.CharField(max_length=140, default='0')
    busser = models.CharField(max_length=140, default='0')
    tip = models.CharField(max_length=140, blank=True)
    total = models.CharField(max_length=140, default='0')

    def __str__(self):
        return str(self.id)

    def tip_is_positive(self):
        if float(tip) >= 0:
            return True
        else:
            return False
