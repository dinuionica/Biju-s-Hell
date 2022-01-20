%include "../../utils/printf32.asm"

section .text
	global cmmmc
    extern printf

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:
    push ebp
   
    push eax
    push edx

gcd:   
    cmp     edx, eax                 ; edx = valoarea cea mai mica
    je final_result
    jle substract
    push eax    ; interschimbare daca nu sunt in ordinea corecta
    push edx
    pop eax
    pop edx

substract:   
    sub     eax,edx                 ; diferenta
    jne     gcd                     ; continua loop
;                     

final_result:

    pop edx
                        ; in eax am cmmdc
    push eax
    pop ecx             ; in ecx am cmmdc
    

    pop eax


    mul edx             ; in eax se determina produsul

   
    xor edx, edx
    div ecx           ;   in eax am impartirea finala
  
    pop ebp
    ret

