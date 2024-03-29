#include<iostream>
using namespace std;

int sqr_it(int x);

int main() {
    int t = 10;
    cout << sqr_it(t) << endl;
    return 0;
}

int sqr_it(int x){
    return x*x;
}

