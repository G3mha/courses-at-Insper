#include<iostream>
using namespace std;

int main() {
    int x;
    cout << "Entre com um número: ";
    cin >> x;

    if(!cin) {
        cout << "Você nao digitou um número!" << endl;
        return 1;
    }
    int y;
    cout << "Entre com outro número: ";
    if(!(cin >> y)){
        cout << "Você não digitou um número!" << endl;
        return 1;
    }

    if (x < y){
        cout << "O primeiro número é menor que o segundo" << endl;
    } 
    else if (x == y) {
            cout << "Os dois números são iguais" << endl;;
        }
    else {
        cout << "O primeiro número é maior que o segundo" << endl;
    }

    cout << "Digite dois números" << endl;
    cin >> x >> y;
    if(!cin){
        cout << "Alguma coisa saiu errado!" << endl;
    }





    return 0;
}