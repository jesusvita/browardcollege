from django.shortcuts import render, redirect, get_object_or_404
from .forms import personalTeppan
from .models import tipOut
import re

def add_items(y):
    x = 0
    add = re.findall('([-+]?\d*\.\d+|\d+)', y)
    for i in add:
        x += float(i)
    return x



def index(request):
    return render(request, 'personal/home.html', )

def tipOutTotal(request):
    return render(request, 'personal/tipOutTotal.html', )

def add_teppan(request):
    if request.method == "POST":
        form = personalTeppan(request.POST)
        if form.is_valid():

            teppan_item = form.save(commit=False)
            teppan_item.sushi = add_items(teppan_item.sushi)
            teppan_item.bar = add_items(teppan_item.bar)
            teppan_item.busser = round((float(teppan_item.teppan) + teppan_item.sushi + teppan_item.bar) * 0.001, 2)
            teppan_item.teppan = round(float(teppan_item.teppan) * 0.085, 2)
            teppan_item.sushi = round(teppan_item.sushi * 0.075, 2)
            teppan_item.bar = round(teppan_item.bar * 0.045, 2)
            teppan_item.save()
            return redirect("/" + str(teppan_item.id) + "/")
    else:
        form = personalTeppan()
    return render(request, 'personal/home.html', {'form': form})

def benihana(request, id=id):
     tipout = tipOut.objects.get(id=id)
     return render(request, 'personal/tipOutTotal.html', {'ben': ben})