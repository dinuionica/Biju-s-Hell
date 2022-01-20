%include "../../utils/printf32.asm"


section .text
	global par
	extern printf

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	
	push ebp 

	;PRINTF32 `%d\n\x0`, edx	; lungime string
	;PRINTF32 `%s\n\x0`, eax	; string 

	xor ecx, ecx
	xor ebx, ebx		; contor 

for:

	cmp ebx, 0  ; daca am o paranteza ) inainte de una (
	jl final_result

	cmp byte [eax + ecx], '('
	je increment

	cmp byte [eax + ecx], ')'
	je decrement 
	inc ecx
	cmp ecx, edx
	jl for
	jmp final_result

increment:
	inc ebx
	inc ecx
	cmp ecx, edx
	jl for
	jmp final_result

decrement:
	dec ebx
	inc ecx
	cmp ecx, edx
	jl for
	jmp final_result


final_result:
	xor eax, eax
	cmp ebx, 0 ; daca contorul este 0, inseamna ca parantezele sunt corecte
	je put_1
	jmp final

put_1:
	add eax, 1

final:
	pop ebp
	ret
