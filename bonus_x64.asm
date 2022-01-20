section .text
	global intertwine

; rcx -> n1
; rax -> v1
; rsi -> n2
; rdx -> v2
; rbx -> v
intertwine:
	

    enter 0,0	; set up stack frame, must be alligned


	xor r11, r11; asta o sa fie i
	xor r12, r12; asta o sa fie j
	xor r13, r13; asta o sa fie k

continue:
	cmp r11, rcx
	jl posibil_while_mare

	jmp while_mici


posibil_while_mare:

	cmp r12, rsi 
	jl while_1
	jmp while_mici

while_1:

	mov dword edi, [rax + r11 * 4]


	mov dword [r8 + r13 * 4], edi


	
	inc r13
	inc r11
	
	;arr3[k++] = arr2[j++]
	mov dword edi, [rdx + r12 * 4]
	mov dword [r8 + r13* 4], edi
	inc r13
	inc r12
	
	jmp continue
	


while_mici:
	cmp r11, rsi
	jl n1_mare

	cmp r12, rcx
	jl n2_mare

	jmp final

n1_mare:
	xor edi, edi
	;arr3[k++] = arr1[i++];	
	mov dword edi, [rax + r11 * 4]
	mov dword [r8 + r13 * 4], edi
	inc r13
	inc r11

	jmp while_mici	

n2_mare:
	xor edi, edi
	;arr3[k++] = arr2[j++]
	mov dword edi, [rdx + r12 * 4]
	mov dword [r8 + r13 * 4], edi
	inc r13
	inc r12
	jmp while_mici	

final:
	leave
	ret			; return
