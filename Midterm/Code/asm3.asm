.MODEL SMALL
.STACK 300h

.DATA
    n      DW 15              ; Length of the array (5)
    arr    DW 10, 12, 15, 14, 20
           DW 1,  4 , 5 , 2 ,  7
           DW 3,  9,  8, 11, 16,  19          ; Last 10 element
.CODE
START:
    MOV BP, 0          ; load the flag
    MOV AX, @DATA      ; Load the data segment address
    MOV DS, AX         ; Set DS register to point to data segment

    MOV CX, 0          ; Outer loop counter: CX as i

OUTER_LOOP:
    MOV DX, [n]        ; Length of array (n)
    SUB DX, 1          ; n - 1
    CMP CX, DX         ; Check if i >= n - 1
    JGE EXIT           ; If i >= n - 1, jump to EXIT
    
    MOV SI, 0          ; Set inner loop counter (j = 0)
    SUB DX, CX         ; Cap for inner loop is DX; n - i - 1
    
    MOV BP, 0        ; Flag to detect if any swap occurred

INNER_LOOP:
    MOV DI, SI         ; Copy SI to DI
    MOV AX, [arr + DI*2] ; Load arr[j] into AX
    MOV BX, [arr + DI*2 + 2] ; Load arr[j+1] into BX
    CMP AX, BX         ; Compare arr[j] and arr[j+1]
    JL  SWAP           ; If arr[j] < arr[j+1], jump to SWAP
    
    JMP ADD_J          ; Else, continue to ADD_J
    
SWAP:
    ; Swap arr[j] and arr[j+1]
    MOV [arr + DI*2 + 2], AX ; arr[j+1] = arr[j]
    MOV [arr + DI*2], BX     ; arr[j] = arr[j+1]
    MOV BP, 1        ; Set flag indicating a swap occurred

ADD_J:
    INC SI             ; Increment inner loop counter (j++)
    CMP SI, DX         ; Check for j < n - 1 - i
    JL INNER_LOOP      ; If j < n - 1 - i, go to INNER_LOOP
    
    ; If no swaps occurred, array is already sorted, exit early
    CMP BP, 0
    JE  EXIT           ; If no swaps, exit the loop
    
    INC CX             ; Increment outer loop counter (i++)
    JMP OUTER_LOOP     ; Go to OUTER_LOOP

EXIT:
    ; Exit Program
    MOV AX, 4C00h
    INT 21h

END START
