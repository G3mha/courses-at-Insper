#include <iostream>
using namespace std;

int main() {

	int x, y;
	cout << "Enter two numbers: ";
	cin >> x >> y;

	if (x<y) {
		cout << "The first is MORE than the second\n";
	} else if (x>y) {
		cout << "The first is LESS than the second\n";
	} else {
		cout << "The numbers are EQUAL\n";
	}

	return 0;
}
