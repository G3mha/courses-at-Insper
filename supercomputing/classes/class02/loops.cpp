#include <iostream>
using namespace std;

int main() {

	int size; // vector size
	cout << "Enter the vector size: ";
	cin >> size;

	int vector[size];
	for (int i=0; i<size; i++) {
		cout << "Input the [" << i << "] element: ";
		cin >> vector[i];
	} 

	for (int i=0; i<size; i++) {
		cout << vector[i] << " ";
	}
	cout << endl;

	return 0;
}
