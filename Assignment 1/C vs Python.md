# Comparing Execution Time and File Size: Python vs C (Hello World 10,000x)

## Overview

Assignment compares the execution time and file size of a simple program that prints "Hello, World!" 10,000 times in **Python** and **C**.

## 1. Python Implementation

### **Code (hello.py)**

```python
for _ in range(10000):
    print("Hello, World!")
```

### **Compilation and Execution**

Convert Python to an executable using **PyInstaller**:

```sh
pyinstaller --onefile hello.py
```

Run the executable and measure time:

```sh
time ./dist/hello
```

Check the executable file size:

```sh
ls -lh ./dist/hello
```

---

## 2. C Implementation

### **Code (hello.c)**

```c
#include <stdio.h>

int main() {
    for(int i = 0; i < 10000; i++) {
        printf("Hello, World!\n");
    }
    return 0;
}
```

### **Compilation and Execution**

Compile and run with:

```sh
gcc hello.c -o hello

time ./hello
```

Check executable file size:

```sh
ls -lh hello
```

---

## 3. Comparison Results

| Metric         | Python (Executable) | C (Executable)   |
| -------------- | ------------------- | ---------------- |
| Execution Time | 0.061s (measure)    | 0.015s (measure) |
| File Size      | 7Mb (measure)       | 131Kb (measure)  |

### **Observations**

- **Performance**: C is faster by 4 times due to compiled execution ,but by printing, C is bottlenecked by system calls
- **File Size**: The C executable is 54 times smaller compared to the Python executable, which includes the Python interpreter.
- **Efficiency**: C provides direct system calls, whereas Python has additional runtime overhead.


