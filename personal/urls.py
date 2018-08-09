from django.urls import path, re_path
from . import views


urlpatterns = [
    path('', views.add_teppan, name='tipOutTotal'),
    re_path(r'(?P<id>\d+)', views.benihana, name='benihana'),


]
