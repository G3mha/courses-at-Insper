#include <iostream>
#include <vector>
#include <algorithm>
#include <random>
using namespace std;

int main()
{
    struct item
    {
        int id;
        double peso;
        double valor;
    };
    int n = 0;
    int W = 0;
    int melhor_valor = 0;
    int amostras = 15;

    vector<item> mochila;
    vector<item> melhor_mochila;
    vector<item> items;
    
    items.reserve(n);
    
    cin >> n >> W; //numero de elementos e peso
    // cout << "Numero de elementos = " << n << "\n";
    // cout << "Capacidade da mochila = " << W << "\n";

    default_random_engine generator(10);
    uniform_real_distribution<double> distribution(0.0, 1.0);

    double peso = 0, valor = 0;
    for (int a = 0; a < n; a++)
    {
        cin >> peso;
        cin >> valor;
        items.push_back({a, peso, valor});

    }

    for(int c = 0; c<amostras; c++) {
        mochila.clear();
        vector<item> items2;
        items2.reserve(n);
        //cout << "====\n";
        // for(auto& el: items){
        //     cout << "passei aqui!\n";
        //     items2.push_back(el);
        // }

        peso = 0;
        valor = 0;
        for(int i = 0; i < n; i++ ){
        
            if (distribution(generator) > 0.5)
            {
                if (items[i].peso + peso <= W)
                {
                    mochila.push_back(items[i]);
                    peso = peso + items[i].peso;
                    valor = valor + items[i].valor;
                   
                }
            } else {
                items2.push_back(items[i]);
            }
        } // milestone: aqui tenho uma solucao aleatória construída
        //agora preciso varrer todos os itens remanescentes e ver se é possível incluí-los.
        for(auto& el: items2){
                if (el.peso + peso <= W) {
                    //cout << "\n inclui com base na busca local - id = "<< el.id << " \n";
                    mochila.push_back(el);
                    peso = peso + el.peso;
                    valor = valor + el.valor;
                }
        }
        if(melhor_valor < valor){
            melhor_valor = valor;
            melhor_mochila = mochila;
        }
        
    }
            
    peso = 0;
    valor = 0;
    for (auto &el : melhor_mochila)
    {
        peso = peso +  el.peso;
        valor = valor + el.valor;
    }
    cout << peso << " " << valor << " 0"
        << "\n";
    sort(melhor_mochila.begin(), melhor_mochila.end(), [](auto &i, auto &j){ return i.id < j.id; });
    for (auto &el : melhor_mochila)
    {
        cout << el.id << " ";
    }
    
    return 0;
}