.MODEL SMALL
.STACK 300h

.DATA
    n      DW 15              ; Length of the array (5)
    arr    DD 10, 12, 15, 14, 20
           DD 1,  4 , 5 , 2 ,  7
           DD 3,  9,  8, 11, 16,  19          ; Last 10 element

.CODE
START:
    MOV BP, 0
    MOV AX, @DATA      ; Load the data segment address
    MOV DS, AX         ; Set DS register to point to data segment

    MOV CX, 0          ; Outer loop counter: CX as i

OUTER_LOOP:
    MOV DX, [n]        ; Length of array (n)
    SUB DX, 1          ; n - 1
    CMP CX, DX         ; check if i >= n - 1
    JGE EXIT           ; if i >= n - 1, jump to EXIT
    
    MOV SI, 0          ; Set inner loop counter (j = 0)
    SUB DX, CX         ; cap for inner loop is DX; n - i - 1
    MOV BP, 0
  
INNER_LOOP:
    MOV DI, SI         ; copy SI to DI
    SHL DI, 2          ; shift left, DI*4
    ADD DI, 2          
    MOV AX, [arr + DI] ; Load arr[j] big half into AX
    ADD DI, 4
    MOV BX, [arr + DI] ; Load arr[j+1] big half into BX
    CMP AX, BX         ; Compare arr[j] and arr[j+1]
    JL  SWAP           ; if arr[j] < arr[j+1], jump to SWAP
    JE  CHECK_LOW      ; if they are equal, we should check the low part
    JMP ADD_J          ; else, continue to ADD_J

CHECK_LOW:
    SUB DI, 2
    MOV BX, [arr+DI]
    SUB DI, 4
    MOV AX, [arr+DI]
    CMP AX, BX
    JL  SWAP           ; if arr[j] < arr[j+1], jump to SWAP
    JMP ADD_J          ; else, continue to ADD_J
    
SWAP:
    ; Swap arr[j] and arr[j+1]
    MOV [arr + DI], AX ; arr[j+1] = arr[j] big part
    SUB DI, 4          ; turn to DI - 4
    MOV [arr + DI], BX ; arr[j] = arr[j+1] big part
    SUB DI, 2
    MOV AX, [arr + DI] ; arr[j] small part
    ADD DI, 4
    MOV BX, [arr + DI] ; arr[j+1] small part
    MOV [arr + DI], AX
    SUB DI, 4
    MOV [arr + DI], BX ; swapping
    MOV BP, 1
    
ADD_J:
    INC SI             ; Increment inner loop counter (j++)
    CMP SI, DX         ; check for j < n - 1 - i
    JL INNER_LOOP      ; if j < n - 1 - i, go to INNER_LOOP
    
    CMP BP, 0
    JE EXIT
    
    INC CX             ; Increment outer loop counter (i++)
    JMP OUTER_LOOP     ; go to OUTER_LOOP

EXIT:
    ; Exit Program
    MOV AX, 4C00h
    INT 21h

END START
