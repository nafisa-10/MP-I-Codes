.MODEL SMALL
.STACK 100H

.DATA
MENU DB 13,10,'SIMPLE CALCULATOR',13,10
     DB '1. Addition',13,10
     DB '2. Subtraction',13,10
     DB '3. Multiplication',13,10
     DB '4. Exit',13,10
     DB 'Enter Choice: $' 
     RESULT DB 13,10,'Result: $'
     MSG DB 13,10,'$'

NUM1 DW 60
NUM2 DW 45

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

START:
    MOV AH,09H
    LEA DX,MENU
    INT 21H

    MOV AH,01H
    INT 21H

    CMP AL,'1'
    JE ADDITION

    CMP AL,'2'
    JE SUBTRACTION

    CMP AL,'3'
    JE MULTIPLICATION

    CMP AL,'4'
    JE EXIT

    JMP START 
    
    
;ADDITION OPERATION    

ADDITION:
    MOV AX,NUM1
    ADD AX,NUM2
    PUSH AX            
                
    ;DISPLAY RESULT 
    
    LEA DX,RESULT
    MOV AH,09H
    INT 21H

    POP AX
    CALL DISPLAY
    
    JMP START
     
    
;SUBTRACTION OPERATION      

SUBTRACTION:
    MOV AX,NUM1
    SUB AX,NUM2 
    PUSH AX
    
    ;DISPLAY RESULT 
    
    LEA DX,RESULT
    MOV AH,09H
    INT 21H

    POP AX
    CALL DISPLAY
    
    JMP START
    
    
;MULTIPLICATION OPERAION

MULTIPLICATION:
    MOV AX,NUM1
    MOV BX,NUM2
    MUL BX   ; RESULT IN AX 
    
    PUSH AX
    
    ;DISPLAY RESULT 
    
    LEA DX,RESULT
    MOV AH,09H
    INT 21H
     
    POP AX 
    CALL DISPLAY
    
    JMP START
    
    
DISPLAY: 

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
     
    ;DIVISOR = 10
     
    MOV BX,10
    
    ;CLEAR DIGIT COUNTER
    
    XOR CX,CX

DIVIDE: 

    ;CLEAR DX BEFORE DIVISION
    
    XOR DX,DX 
    
    ;DIVIDE AX BY 10
    
    DIV BX
    
    PUSH DX ;SAVE REMINDER
    
    INC CX  ;COUNT DIGIT
    
    CMP AX,0  ; CONTINUE UNTIL QUOTIENT BECOME 0
    JNE DIVIDE

PRINT: 

    POP DX
    ADD DL,'0' ;CONVERT DIGIT TO ASCII
    
    ;PRINT DIGIT
    
    MOV AH,02H
    INT 21H

    DEC CX
    CMP CX,0
    JNE PRINT

    LEA DX,MSG
    MOV AH,09H
    INT 21H

    POP DX
    POP CX
    POP BX
    POP AX

    RET
 


EXIT:
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN 