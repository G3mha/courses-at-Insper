#include<iostream>
#include<random>
using namespace std;
int main(){
    default_random_engine generator;
    generator.seed(10);
    //uniform_int_distribution<int> distribution(-2,5);
    uniform_real_distribution<double> distribution(0.0, 1.0);
    for(int i = 0; i < 10; i++) {
        cout << distribution(generator) << " ";
    }
    return 0;
}