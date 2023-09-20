// Class: 07-sorting-algorithms

// Checkpoint 1 - function that verifies that an array of integers is sorted in ascending order

int is_sorted(int v[], int n) {
    for (int i = 0; i < n - 1; i++) {
        if (v[i] > v[i + 1]) {
            return 0;
        }
    }
    return 1;
}

// Checkpoint 2 - mentally sort the following array with the logic below

// repit indefinitely
    // changed = no

    // for each i in (0, 1, 2, ..., n-2)
    //     if v[i] > v[i+1]
    //         swap v[i] and v[i+1]
    //         changed = yes

    // if not changed
    //     break the loop

// array: {4, 5, 2, 3, 1}
// iteration 1: {4, 2, 3, 1, 5}
// iteration 2: {2, 3, 1, 4, 5}
// iteration 3: {2, 1, 3, 4, 5}
// iteration 4: {1, 2, 3, 4, 5}

// Checkpoint 3 - function that implements bubble sort algorithm, with auxiliary function for swap

int swap(int v[], int i, int j) {
    int temp = v[i];
    v[i] = v[j];
    v[j] = temp;
    return 1;
}

void bubble_sort(int v[], int n) {
    int changed = 0;
    do {
        changed = 0;
        for (int i = 0; i < n - 1; i++) {
            if (v[i] > v[i + 1]) {
                changed = swap(v, i, i + 1);
            }
        }
    } while (changed);
}

// Checkpoint 4 - function that implements insertion sort algorithm, with auxiliary function for swap

void insertion_sort(int v[], int n) {
    for (int i = 1; i < n; i++) {
        int j = i;
        while (j > 0 && v[j - 1] > v[j]) {
            swap(v, j - 1, j);
            j--;
        }
    }
}

// all of them are O(n^2) algorithms