#include<iostream>
#include<vector>
#include<algorithm>
using namespace std;

int main() {
    struct item
    {
        int id;
        double peso;
        double valor;
        
    };

    int n = 0;
    int W = 0;

    vector<item> mochila;

    cin >> n >> W; //numero de elementos e peso
    vector<item> items;
    items.reserve(n);
    double peso, valor;
    for(int i = 0; i < n; i++) {
        cin >> peso;
        cin >> valor;
        items.push_back({i, peso, valor});
    }
    //ordenacao dos itens
    sort(items.begin(), items.end(), [](auto& i, auto& j){return i.peso < j.peso;});
    peso = 0;
    valor = 0;
    for(auto& el : items){
       if (el.peso + peso <= W) {
           mochila.push_back(el);
           peso = peso + el.peso;
           valor = valor + el.valor;
       }
    }
    //essa ordenacao é necessaria para atender apenas o solicitado. 
    sort(mochila.begin(), mochila.end(), [](auto& i , auto& j){return i.id < j.id;});
    cout << peso << " " << valor << " 0" << "\n";

    for(auto& el: mochila) {
        cout << el.id << " ";
    }

    return 0;
}