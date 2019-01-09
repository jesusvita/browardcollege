from django.db import models

class tipOut(models.Model):
    username = models.CharField(max_length=140, default='0')
    password = models.CharField(max_length=140, default='0')


    def __str__(self):
        return str(self.id)

    def tip_is_positive(self):
        if float(tip) >= 0:
            return True
        else:
            return False
