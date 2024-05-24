#include<iostream>
#include<string>
using namespace std;
int main() {

    int x;
    cout << "Entre com um número: ";
    cin >> x;

    cout << "Você digitou o valor " << x << endl;

    int y;
    string s;
    y = 2*x;
    x = y + 5;
    cout << "x = " << x << endl;
    cout << "y = " << y << endl;

    cout << "Digite uma string" << endl;
    cin >> s;
    cout << "Você digitou " << s << endl;

    return 0;
}