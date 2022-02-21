section .data
    ; delimitation used to separate words
    word_delimiter db " .,", 10, 0

section .text
global get_words
global sort
global compare

extern qsort
extern strtok
extern strlen
extern strcmp

sort:
    enter 0, 0
    ; array of words
    mov ecx, [ebp + 8]
    ; number of words
    mov ebx, [ebp + 12]
    ; size value of an element
    mov edx, [ebp + 16]
    
    ; adding parameters on the stack for calling the qsort function  
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

    ; first string argument
    mov edx, [ebp + 8]
    ; second string argument 
    mov ecx, [ebp + 12]
    
    ; put the values ​​on the stack for strcmp function
    push dword [ecx]
    push dword [edx]

    ; determining the length of the first string received as an argument
    push dword [edx]
    call strlen
    add esp, 4
    
    ; within the eax register is the length of the first string
    push eax

    mov ecx, [ebp + 12]
    push dword [ecx]
    call strlen
    add esp, 4

    ; within the eax register is the length of the second string,
    ; and the value moves to the ecx register
    mov ecx, eax

    ; the length of the first string is taken from the stack
    ; and is determined the difference between the two lengths 
    pop eax
    sub eax, ecx

    ; if the two lengths are equal, call the strcmp function
    je call_strcmp 

    jmp ending

call_strcmp:
       
    call strcmp
      
ending:
      ; free the stack and return 
      add esp, 8
      pop ecx
      pop esi

      leave
      ret

get_words:

    enter 0, 0

    ; the string
    mov eax, [ebp + 8]
    ; the address of the array with words
    mov ebx, [ebp + 12]
    ; the number of words
    mov edi, [ebp + 16]
  
    ; adding parameters on the stack for calling the strtok function  
    push word_delimiter
    push eax
    call strtok
    add esp, 8

    ; add the word obtained after the strtok call in the final array
    mov [ebx + 0], eax
    
    ; initializing the counter used for loop
    xor edx, edx
    mov edx, 1

loop:

    ; adding the counter to the stack
    push edx
    
    ; adding parameters on the stack for calling the strtok function  
    push word_delimiter
    push 0
    call strtok
    add esp, 8
    
    ; access the current counter and add the word obtained after the
    ; strtok call in the final array of words
    pop edx
    mov [ebx + edx * 4], eax 

    ; incrementthe counter and continue the iteration
    inc edx
    cmp edi, edx
    jg loop

    leave
    ret
