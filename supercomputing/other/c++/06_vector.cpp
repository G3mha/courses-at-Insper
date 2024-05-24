#include<iostream>
#include<vector>
#include<algorithm>

using namespace std;
bool my_compare(float a, float b);
int main() {

    vector<float> nums;

    //inserindo um valor no vector
    nums.push_back(10.5);

    //obtendo o valor
    cout << nums[0] << endl;

    //apagando o primeiro elemento

    nums.erase(nums.begin());

    //exibindo o tamanho do vector

    cout << nums.size() << endl;

    nums.push_back(4.0);
    nums.push_back(7.5);
    nums.push_back(23.4);
    
    cout << nums.size() << endl;

    //fazendo uso de assign, popular um vector
    nums.assign(100, 0.5); //adiciona 100 floats de valor 0.5

    cout << nums.size() << endl;

    for(auto& e: nums)
        cout << e << "\t";

    //apagando o vector
    nums.clear();

    nums.push_back(4.0);
    nums.push_back(7.5);
    nums.push_back(23.4);

    //ordenando
    sort(nums.begin(), nums.end(), my_compare);

    for(auto e: nums)
        cout << e << "\t";




    return 0;
}

bool my_compare(float a, float b){
    return a > b; //ordenacao decrescente
}