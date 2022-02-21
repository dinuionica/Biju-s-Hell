section .text
	global cmmmc

cmmmc:
    ; adding items to the stack
    push ebp
    push eax
    push edx

gcd:   
    ; the two numbers are compared, the lowest value being in the edx register
    ; and is determined the value of gdc using the Euclidean algorithm 
    cmp edx, eax   
    je calculate_lcm
    jle difference

    ; if the two elements are not in the desired order,
    ; the values ​​are exchanged using the stack
    push eax 
    push edx
    pop eax
    pop edx

difference:  
    ; make the difference between the two numbers
    sub eax,edx     
    ; continue the algorithm           
    jne gcd     

calculate_lcm:

    ; accessing the number from the stack
    pop edx 
    ; within the eax register there is the gdc value of the two numbers
    push eax
    ; the value is added to the ecx register (gdc)
    pop ecx
    
    ; the product of the two numbers is determined in the eax register 
    pop eax
    mul edx           

    ; the final value for lcm is obtained in the eax register by
    ; dividing the product by gdc (lcm  = (a * b) / gdc)
    xor edx, edx
    div ecx 
  
    pop ebp
    ret
