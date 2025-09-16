.text
.global _main
.extern _puts

_main:
    mov x1, 2         // x1 = 2
    mov x2, 3         // x2 = 3
    add x3, x1, x2    // x3 = x1 + x2

    // Print x3
    mov x1, x3        // move result to x1 for int_to_str
    adrp x2, buffer@PAGE    // x2 = page address of buffer
    add  x2, x2, buffer@PAGEOFF // x2 = address of buffer
    bl int_to_str           // convert x1 to string at buffer
    adrp x0, buffer@PAGE    // x0 = page address of buffer
    add  x0, x0, buffer@PAGEOFF // x0 = address of buffer for puts
    bl _puts                // print the string
    mov w0, #0
    ret

// Integer to string conversion (x1: value, x2: buffer)
int_to_str:
    mov x3, x1              // x3 = value
    mov x4, x2              // x4 = buffer pointer
    mov x5, 10              // x5 = divisor (10)
    mov x6, 0               // x6 = digit count

    // Find digits (in reverse)
1:
    udiv x7, x3, x5         // x7 = x3 / 10
    msub x8, x7, x5, x3     // x8 = x3 - (x7 * 10) (remainder)
    add x8, x8, '0'         // convert digit to ASCII
    strb w8, [x4, x6]       // store digit
    mov x3, x7              // x3 = x3 / 10
    add x6, x6, 1           // digit count++
    cbz x3, 2f              // if x3 == 0, done
    b 1b

2:
    // Reverse digits in buffer
    mov x9, 0               // i = 0
    sub x10, x6, 1          // j = digit count - 1
3:
    ldrb w11, [x4, x9]      // temp = buffer[i]
    ldrb w12, [x4, x10]     // temp2 = buffer[j]
    strb w12, [x4, x9]      // buffer[i] = temp2
    strb w11, [x4, x10]     // buffer[j] = temp
    add x9, x9, 1
    sub x10, x10, 1
    cmp x9, x10
    b.lt 3b                 // while i < j

    // Null-terminate
    add x4, x4, x6
    mov w13, 0
    strb w13, [x4]
    ret

.section __DATA,__data
buffer:
    .space 32