from django.db import models

class Team(models.Model):
    name = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return self.name
    
class Competition(models.Model):
    name = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return self.name

class Football(models.Model):
    name = models.CharField(max_length=50)

# https://medium.com/@Usmanajibola/advanced-django-queries-you-should-know-47bbebdf121b