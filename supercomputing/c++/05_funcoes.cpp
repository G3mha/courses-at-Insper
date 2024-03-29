#include <iostream>
#include <vector>
#include <string>
using namespace std;

vector<int> read_int_vector();
float average(vector<int> v);
int sum(vector<int> v);

int main() {
   
    vector<int> v = read_int_vector();
    // for(auto e: v)
    //     cout << e << endl;
    cout << "Média " << average(v) << endl;

    return 0;
}

vector<int> read_int_vector() {
    vector<int> result;
    int x;
    cout << "Entre com os números:" << endl;
    while (true) {
        while(cin >> x)
            result.push_back(x);
        if(cin.eof())
            break;
        cin.clear();
        string s;
        getline(cin, s);
        cout << "Atencão, ignorando: " << s << endl;
    }  
    
    return result;  
}

float average(vector<int> v){
    if(v.empty())
        return 0;
    int size = v.size();
    return sum(v)/size;

} 

int sum(vector<int> v) {
    int total = 0;
    for(auto e: v)
        total =+ e;
    cout << "total = " << total << endl;
    return total;
}