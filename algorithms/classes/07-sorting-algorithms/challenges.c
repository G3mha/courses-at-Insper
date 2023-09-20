int swap(int v[], int i, int j) {
    int temp = v[i];
    v[i] = v[j];
    v[j] = temp;
    return 1;
}

// Challenge 1 - function that implements bubble sort algorithm, recursively
// write it down

void bubble_sort(int v[], int n) {
    if (n == 1) {
        return;
    }
    for (int i = 0; i < n - 1; i++) {
        if (v[i] > v[i + 1]) {
            swap(v, i, i + 1);
        }
    }
    bubble_sort(v, n - 1);
}

// Challenge 2 - function that implements selection sort algorithm, recursively

void selection_sort(int v[], int n) {
    if (n == 1) {
        return;
    }
    int max = 0;
    for (int i = 1; i < n; i++) {
        if (v[i] > v[max]) {
            max = i;
        }
    }
    swap(v, max, n - 1);
    selection_sort(v, n - 1);
}

// Challenge 3 - function that implements insertion sort algorithm, recursively

void insertion_sort(int v[], int n) {
    if (n == 1) {
        return;
    }
    insertion_sort(v, n - 1);
    int j = n - 1;
    while (j > 0 && v[j - 1] > v[j]) {
        swap(v, j - 1, j);
        j--;
    }
}
