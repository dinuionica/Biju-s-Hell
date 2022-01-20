global get_words
global sort
global compare
extern qsort
extern printf
extern strtok
extern strlen
extern strcmp

section .data
    delimitator db " .,", 10, 0

section .text


sort:
    enter 0, 0
    mov ecx, [ebp + 8]  ; vector words
    mov ebx, [ebp + 12] ; numar cuvinte
    mov edx, [ebp + 16] ; valoare size
  
    push my_compare
    
    push edx
   
    push ebx
   
    push ecx
  
    call qsort
    add esp, 16

    leave
    ret
    
my_compare:   
    
    enter 0,0

    push esi
    push ecx

    mov edx, [ebp + 8] ; argument 1

    mov ecx, [ebp + 12] ; argument 2
    
    push dword [ecx]

    push dword [edx] ; pun valorile pe stiva pentru strcmp 


    push dword [edx]
    call strlen
    add esp, 4
    ; mov esi, eax ; pun in esi lungime argument 1

    push eax

    mov ecx, [ebp + 12]
    push dword [ecx]
    call strlen
    add esp, 4

    mov ecx, eax

    pop eax

    sub eax, ecx

    je call_strcmp ; daca sunt egale apelez qsort
    jmp free_stack

call_strcmp:
       
    call strcmp
      
free_stack:
      add esp, 8
      pop ecx
      pop esi

final:
      leave
      ret


get_words:
    enter 0, 0
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov edi, [ebp + 16]
  

    push delimitator
    push eax
    call strtok
    add esp, 8
    mov [ebx + 0], eax
  

    xor edx, edx
    mov edx, 1

loop:
    push edx
    
    push delimitator
    push 0
    call strtok
    add esp, 8
    
    pop edx

    mov [ebx + edx * 4], eax  ; pun stringul mic in ebx

    inc edx
    cmp edi, edx
    jg loop

final_loop:
    leave
    ret


