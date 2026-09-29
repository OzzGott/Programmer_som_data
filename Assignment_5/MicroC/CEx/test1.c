void main(int i){
    int sum;    
    int arr[4];
    int *p;
    sum = 0;
    p = &sum;
    
    arr[0] = 7;
    arr[1] = 13;
    arr[2] = 9;
    arr[3] = 8;
 
    arrsum(i, arr, p);
    print(sum);
}

void arrsum(int n, int arr[], int *sump){
    int i;
    *sump = 0;
    for (i = 0; i < n; i = i + 1)
        *sump = *sump + arr[i];
}   