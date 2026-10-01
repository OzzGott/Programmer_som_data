void main(int i){
    int arr[20];
    int sum;
    squares(i, arr);
    arrsum(i, arr, &sum);
    print(sum);
}

void squares(int n, int arr[]){
    int i;
    for (i = 0; i < n; i = i + 1)
        arr[i] = i * i;
}

void arrsum(int n, int arr[], int *sump){
    int i;
    *sump = 0;
    for (i = 0; i < n; i = i + 1)
        *sump = *sump + arr[i];
}   