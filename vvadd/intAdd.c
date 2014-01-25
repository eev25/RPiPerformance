//#include <stdio.h>

__attribute__((noinline))
void intAdd(int a[], int b[], int c[],int n) {

   int i;
   for (i = 0; i < n; i++) {
      c[i] = a[i] + b[i];
   }

}
