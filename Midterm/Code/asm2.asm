.MODEL SMALL
.STACK 300h

.DATA
    n      DW 100              ; Length of the array (5)
    arr    DW 27, -5, 43, 35, -50, 14, -13, 42, -18, 9,           ; First 10 elements
           DW -35, 31, -48, 21, 46, -21, -44, -7, 11, 49,          ; Next 10 elements
           DW 33, -27, -3, -8, -42, 17, 7, -25, 10, 26,            ; Next 10 elements
           DW 45, -10, 29, -36, 6, -17, -30, -33, -6, 2,            ; Next 10 elements
           DW -1, 34, 3, -26, 20, 13, -19, -12, 24, -22,            ; Next 10 elements
           DW -2, 4, -32, 23, -29, 8, 12, 48, -16, -31,             ; Next 10 elements
           DW 38, 32, 16, 50, -40, 19, -15, 41, -4, -39,             ; Next 10 elements
           DW 5, -14, -24, -28, -9, 1, 37, 15, -23, -49,             ; Next 10 elements
           DW 36, 18, -11, 40, -38, 47, -37, -46, 39, 25,            ; Next 10 elements
           DW -45, -41, -47, -20, 22, -6, 28, -34, 30, 44            ; Last 10 element

.CODE
START:
    MOV AX, @DATA      ; Load the data segment address
    MOV DS, AX         ; Set DS register to point to data segment

    MOV CX, [n]          ; Outer loop counter: CX as i
    DEC CX               ; int i = n - 1, initial value of i

OUTER_LOOP:
    MOV DX, [n]        ; Length of array (n)
    SUB DX, 1          ; n - 1
    CMP CX, 0         ; check if i > 0
    JLE EXIT           ; if i <= 0, jump to EXIT
    
    MOV SI, DX          ; Set inner loop counter (j = n - 1)
    SUB DX, CX         ; cap for inner loop is DX; n - i - 1
  
INNER_LOOP:
    MOV DI, SI         ; copy SI to DI
    SHL DI, 1          ; shift left, DI*2
    MOV AX, [arr + DI] ; Load arr[j] into AX
    SUB DI, 2
    MOV BX, [arr + DI] ; Load arr[j-1] into BX
    CMP AX, BX         ; Compare arr[j] and arr[j-1]
    JG  SWAP           ; if arr[j] > arr[j-1], jump to SWAP
    JMP SUB_J          ; else, continue to SUB_J
    
SWAP:
    ; Swap arr[j] and arr[j+1]
    MOV [arr + DI], AX ; arr[j-1] = arr[j]
    ADD DI, 2          ; turn to DI+ 2
    MOV [arr + DI], BX ; arr[j] = arr[j-1]
    
SUB_J:
    DEC SI             ; Decreament inner loop counter (j--)
    CMP SI, DX         ; check for j > n - 1 - i
    JG INNER_LOOP      ; if j > n - 1 - i, go to INNER_LOOP
    
    DEC CX             ; Decreament outer loop counter (i--)
    JMP OUTER_LOOP     ; go to OUTER_LOOP

EXIT:
    ; Exit Program
    MOV AX, 4C00h
    INT 21h

END START
