from django.urls import path, include, re_path
from django.views.generic import ListView, DetailView
from personal.models import tipOut
from . import views

urlpatterns = [
    path('', views.add_teppan, name='tipOutTotal'),
    path(r'<pk>/', DetailView.as_view(model=tipOut,
                                            template_name="personal/tipOutTotal.html")),

]
