section .text
	global par

par:

	push ebp 

	; initializing the counter used for iteration of the string
	xor ecx, ecx
	; initialization of the counter used to keep track of parentheses
	xor ebx, ebx

string_iteration:

	; if there is a closed parenthesis ) before an open one ( is 
	; returned a false answer because it is not a correct sequence.
	cmp ebx, 0
	jl final_result

	; if the current character is an open parenthesis,
	; the ebx counter is incremented
	cmp byte [eax + ecx], '('
	je increment

	; if the current character is an closed parenthesis,
	; the ebx counter is decremented
	cmp byte [eax + ecx], ')'
	je decrement 
	jmp continue_iteration

increment:

	; apply an increment and continue the iteration
	inc ebx
	jmp continue_iteration

decrement:

	; apply a decrement and continue the iteration
	dec ebx
	jmp continue_iteration

continue_iteration:

	; continue the iteration through each character of the string
	inc ecx
	cmp ecx, edx
	jl string_iteration
	jmp final_result

final_result:

	; if the counter is 0, it means that the parentheses are correct
	xor eax, eax
	cmp ebx, 0
	; updates the value of the eax register by 1 for a correct sequence
	; otherwise the value remains 0 for an invalid sequence
	je update_eax
	jmp ending

update_eax:

	; updates the value of the eax register by 1 for a correct sequence
	add eax, 1

ending:
	pop ebp
	ret
