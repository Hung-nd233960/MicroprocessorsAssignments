# 8-bit Floating-Point (FP8) vs. 8-bit Fixed-Point (INT8/Q8)

Explains the differences between **8-bit floating-point (FP8)** and **8-bit fixed-point (INT8/Q8)** representations, including formats, precision, and accuracy comparisons.

---

## 1. 8-bit Floating-Point Representation (FP8)

Floating-point numbers use an exponent and a fraction (mantissa) to represent a wide range of values. **FP8** is a small floating-point format used in AI/ML for reduced memory and computation.

### FP8 Formats

Common **FP8** formats include:

1. **E4M3** (4-bit exponent, 3-bit mantissa, 1-bit sign)  
   - Balanced range and precision.
   - Example: `1 0110 101` → **-0.8125 × 2^6** = **-52.0**

2. **E5M2** (5-bit exponent, 2-bit mantissa, 1-bit sign)  
   - Larger range, but reduced precision.
   - Example: `0 10111 01` → **1.25 × 2^23** = **10,485,760.0**

### Pros of FP8
- **High dynamic range** compared to fixed-point.
- **Efficient memory usage** in deep learning.
- **Better for AI models** that require small-scale floating operations.

### Cons of FP8
- **Lower precision** than FP16 or FP32.
- **Hardware acceleration is needed** for efficient computation.

---

## 2. 8-bit Fixed-Point Representation (INT8/Q8)

Fixed-point representation divides bits between integer and fractional components. Unlike floating-point, it does not have an exponent.

### Common Fixed-Point Formats

1. **Q7 (1 Integer, 7 Fractional Bits)**
   - Format: `S FFFFFF.F`
   - Range: **-1 to 0.9921875**
   - Example: `01111111` → **0.9921875**

2. **Q3.4 (3 Integer, 4 Fractional Bits)**
   - Format: `S III.FFFF`
   - Range: **-8 to 7.9375**
   - Example: `0011.1010` → **3.625**

### Pros of Fixed-Point (INT8/Q8)
- **Consistent precision** across its range.
- **Faster computations** (simple integer math).
- **Better for DSP, embedded systems, and audio processing.**

### Cons of Fixed-Point (INT8/Q8)
- **Limited dynamic range.**
- **More manual scaling required** to fit values into the fixed representation.

---

## 3. Accuracy Comparison: FP8 vs. INT8/Q8

| Feature                      | FP8 (E4M3 / E5M2)                          | Fixed-Point (INT8/Q8)               |
| ---------------------------- | ------------------------------------------ | ----------------------------------- |
| **Precision**                | High near zero, lower for large numbers    | Uniform across range                |
| **Range**                    | Large (varies with exponent)               | Limited (-8 to 7.9375 in Q3.4)      |
| **Computational Complexity** | Higher (floating-point operations)         | Lower (integer-based math)          |
| **Memory Usage**             | Efficient in AI models                     | Efficient in DSP, control systems   |
| **Use Case**                 | AI/ML, deep learning, scientific computing | Embedded systems, DSP, game physics |

### Key Takeaways
- **FP8 is better for AI/ML applications** where dynamic range matters more than absolute precision.
- **Fixed-point (INT8/Q8) is better for low-power, high-speed computations** where precision must remain uniform across all values.
- **FP8 introduces rounding errors and non-uniform precision**, while **fixed-point maintains steady precision at the cost of range.**


