from django.urls import path, re_path
from . import views


urlpatterns = [
    path('', views.index, name='tipOutTotal'),
    re_path('login', views.benihana, name='benihana'),
    path('grades', views.tipOutTotal),
    path('grades/2018', views.grades),


]
