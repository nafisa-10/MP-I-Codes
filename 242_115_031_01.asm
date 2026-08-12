.MODEL SMALL
.STACK 100H

.DATA

     TITLEMSG   DB 13,10,'STUDENT RESULT',13,10,'$'
     TOTALM  DB 13,10,'TOTAL MARKS : $'
     AVGM    DB 13,10,'AVERAGE : $'
     GRADEM  DB 13,10,'GRADE : $'
     NEWLINE DB 13,10,'$'

     MATH DW 78
     PHY  DW 82
     PROG DW 91

     TOTAL DW ?
     AVG DW ?

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    ; DISPLAY THE TITLE
    
    LEA DX,TITLEMSG
    MOV AH,09H
    INT 21H

    ; CALCULATE TOTAL MARKS
    
    MOV AX,MATH
    ADD AX,PHY
    ADD AX,PROG
    MOV TOTAL,AX
    
    PUSH AX

    ; DISPLAY TOTAL  MARKS 
    
    LEA DX,TOTALM
    MOV AH,09H
    INT 21H

   
    POP AX
    CALL DISPLAY

    ; CALCULATE AVERAGE MARKS
    MOV AX,TOTAL
    MOV BX,3
    XOR DX,DX
    DIV BX
    MOV AVG,AX
              
    PUSH AX           
               
    ; DISPLAY AVERAGE MARKS
    LEA DX,AVGM
    MOV AH,09H
    INT 21H

    POP AX
    
    CALL DISPLAY

    ; DISPLAY THE GRADE
    
    LEA DX,GRADEM
    MOV AH,09H
    INT 21H

    MOV AX,AVG

    CMP AX,80
    JAE GRADE_A

    CMP AX,70
    JAE GRADE_B

    CMP AX,60
    JAE GRADE_C

    JMP GRADE_F

GRADE_A:
    MOV DL,'A'
    JMP PRINTGRADE

GRADE_B:
    MOV DL,'B'
    JMP PRINTGRADE

GRADE_C:
    MOV DL,'C'
    JMP PRINTGRADE

GRADE_F:
    MOV DL,'F'

PRINTGRADE:
    MOV AH,02H
    INT 21H

    MOV AH,4CH
    INT 21H

MAIN ENDP

;DISPLAY NUMBER IN AX

DISPLAY:

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX,10
    XOR CX,CX

DIVIDE:
    XOR DX,DX
    DIV BX
    PUSH DX
    INC CX

    CMP AX,0
    JNE DIVIDE

PRINT:
    POP DX
    ADD DL,'0'
    MOV AH,02H
    INT 21H

    DEC CX
    CMP CX,0
    JNE PRINT

    LEA DX,NEWLINE
    MOV AH,09H
    INT 21H

    POP DX
    POP CX
    POP BX
    POP AX

    RET

END MAIN