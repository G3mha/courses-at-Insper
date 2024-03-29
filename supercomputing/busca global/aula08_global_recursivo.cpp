#include<iostream>
#include<vector>
#include<algorithm>
using namespace std;

struct item
{
    int id;
    double peso;
    double valor;
    
};

double knapSack2(int W, vector<item> items, vector<item>& usados, vector<item>& melhor){
    double valor = 0.0;
    double peso = 0.0;
    double sem_i = 0.0, com_i = 0.0;
    vector<item> items2 = items;
    if(items.empty() || W == 0)
        return 0;
    if(items[0].peso <= W){
        usados.push_back(items[0]);
        valor = items[0].valor;
        peso = items[0].peso;
        items.erase(items.begin());
        com_i = knapSack2(W - peso, items, usados, melhor);
    }
    items2.erase(items2.begin());
    sem_i = knapSack2(W, items2, usados, melhor);
    double valor_atual = 0.0, valor_melhor = 0.0;
    for(auto& el : usados){
        valor_atual += el.valor;
    }
    for(auto& el : melhor){
        valor_melhor += el.valor;
    }
    if(valor_atual > valor_melhor)
        melhor = usados;
    usados.clear();
    return max(sem_i, valor + com_i);
    
}

// double knapSack(int W, std::vector<item> items){
//     if(items.empty() || W == 0){
//         return 0;
//     }
//     if(items[0].peso > W){
//         items.erase(items.begin());
//         return knapSack(W,items);
//     }    
//     else {
//         double valor = items[0].valor;
//         double peso = items[0].peso;
       
//         items.erase(items.begin());
//         return max(valor + knapSack(W - peso,items), knapSack(W, items));
//      }
// }

int main() {

    int n = 0;
    int W = 0;

    vector<item> mochila;

    cin >> n >> W; //numero de elementos e peso
    // cout << "Numero de elementos = " << n << "\n";
    // cout << "Capacidade da mochila = " << W << "\n";
    vector<item> items;
    vector<item> usado;
    vector<item> melhor;
    items.reserve(n);
    usado.reserve(n);
    double peso, valor;
    for(int i = 0; i < n; i++) {
        cin >> peso;
        cin >> valor;
        items.push_back({i, peso, valor});
    }
    
    cout << "RESULTADO = " << knapSack2(W, items, usado, melhor) << "\n";
    for(auto& el: melhor) {
            cout << el.id << " ";
    }

    // //ordenacao dos itens
    // sort(items.begin(), items.end(), [](auto& i, auto& j){return i.valor > j.valor;});
    // peso = 0;
    // valor = 0;
    // for(auto& el : items){
    //    if (el.peso + peso <= W) {
    //        mochila.push_back(el);
    //        peso = peso + el.peso;
    //        valor = valor + el.valor;
    //    }
    // }
    //essa ordenacao é necessaria para atender apenas o solicitado. 
    // sort(mochila.begin(), mochila.end(), [](auto& i , auto& j){return i.id < j.id;});
    // cout << peso << " " << valor << " 0" << "\n";

    // for(auto& el: mochila) {
    //     cout << el.id << " ";
    // }
    return 0;
}


