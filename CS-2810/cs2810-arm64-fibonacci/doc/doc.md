Fibonacci numbers
=================

Write an assembly language function to compute numbers in the
Fibonacci sequence. The function will take a single parameter and
return a singe result. You should write your code to closely mimic
the following C function:

``` c
int fibonacci(int n) {
    int a = 1;
    int b = 1;

    for (int i = 2; i < n; i++) {
        int temp = a + b;
        a = b;
        b = temp;
    }

    return b;
}
```
