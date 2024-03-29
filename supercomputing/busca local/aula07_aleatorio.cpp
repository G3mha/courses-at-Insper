#include <iostream>
#include <vector>
#include <algorithm>
#include <random>
#include <chrono> //para mudarmos a semente
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

    vector<item> mochila;
    vector<item> items;
    items.reserve(n);

    cin >> n >> W; //numero de elementos e peso
    // cout << "Numero de elementos = " << n << "\n";
    // cout << "Capacidade da mochila = " << W << "\n";

    default_random_engine generator(10);
    uniform_real_distribution<double> distribution(0.0, 1.0);

    double peso = 0, valor = 0;
    for (int i = 0; i < n; i++)
    {
        cin >> peso;
        cin >> valor;
        items.push_back({i, peso, valor});
    }

    for(int c = 0; c<10; c++) {
        cout << "\n==========\n";
        mochila.clear();

        peso = 0;
        valor = 0;
        for (auto &el : items)
        {
            if (distribution(generator) > 0.5)
            {
                if (el.peso + peso <= W)
                {
                    mochila.push_back(el);
                    peso = peso + el.peso;
                    valor = valor + el.valor;
                }
            }
        }
            sort(mochila.begin(), mochila.end(), [](auto &i, auto &j){ return i.id < j.id; });
            cout << peso << " " << valor << " 0"
                << "\n";
            for (auto &el : mochila)
            {
                cout << el.id << " ";
            }
    }
    return 0;
}