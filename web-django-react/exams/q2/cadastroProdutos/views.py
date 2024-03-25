from django.shortcuts import render, redirect
from .models import Cadastro

# CRUD - Create, Read, Update, Delete

def index(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        quantity = request.POST.get('quantity')
        # Fazer um if para identificar o request que vem do form de comprar
        # e fazer um update no campo quantity
        if 'comprar' in request.POST:
            new_quantity = int(quantity)
            new_quantity = int(quantity) - 1
            if new_quantity < 0:
                new_quantity = 0
            print('#' * 50)
            Cadastro.objects.filter(name=name).update(quantity=new_quantity)
        if 'cadastrar' in request.POST:
            cadastro = Cadastro.objects.create(name=name, quantity=quantity)
            cadastro.save()
        return redirect('index')
    else:
        # return all objects that have quantity different than 0
        all_cadastros = Cadastro.objects.filter(quantity__gt=0)
        return render(request, 'cadastroProdutos/index.html', {'cadastroProdutos': all_cadastros})