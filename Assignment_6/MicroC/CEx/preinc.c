void main() {
  int arr[3];
  int i;
  arr[0] = 10; arr[1] = 20; arr[2] = 30;
  i = 0;
  print ++i;           // 1
  print --i;           // 0
  print ++arr[++i];    // i becomes 1, arr[1] becomes 21: prints 21
  print i;             // 1
  print arr[0];        // 10
  print arr[1];        // 21
  print arr[2];        // 30
  println;
}