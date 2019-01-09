from django.shortcuts import render, redirect, get_object_or_404
from .forms import personalTeppan
from .models import tipOut
import re
import os
import time


def add_items(y):
    x = 0
    add = re.findall('([-+]?\d*\.\d+|\d+)', y)
    for i in add:
        x += float(i)
    return x



def index(request):
    return render(request, 'personal/home.html', )

def tipOutTotal(request):
    return render(request, 'personal/index.html', )

def add_teppan(request):
    if request.method == "POST":
        # form = personalTeppan(request.POST)

        return redirect("/login/")
    else:
        form = personalTeppan()
    return render(request, 'personal/home.html', {'form': form})

def benihana(request):

        return render(request, 'personal/tipOutTotal.html')

def grades(request):
    return render(request,'personal/basic.html')
