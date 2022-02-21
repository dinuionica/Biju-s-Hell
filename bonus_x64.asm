section .text
	global intertwine

intertwine:
	
    enter 0,0

	; initialization of counters for accessing the elements within the arrays
	xor r11, r11
	xor r12, r12	
	xor r13, r13

check_first_condition:

	; check if the first array still has elements
	cmp r11, rcx
	jl check_second_condition

	; if the condition is not met it means that an array has no more 
	; elements and the secondary loops are performed
	jmp secondary_loops

check_second_condition:

	; check if the first array still has elements
	cmp r12, rsi 
	jl first_loop
	
	; similarly, an array has length 0
	jmp secondary_loops

first_loop:

	; add the elements from the two secondary arrays
	; alternately in the final array at the desired position

	; v[size++] = v1[i++]
	mov dword edi, [rax + r11 * 4]
	mov dword [r8 + r13 * 4], edi
	; increment the counters
	inc r13
	inc r11
	
	; v[size++] = v2[j++]
	mov dword edi, [rdx + r12 * 4]
	mov dword [r8 + r13* 4], edi
	; increment the counters
	inc r13
	inc r12
	
	; continue the iteration by checking the first condition again
	jmp check_first_condition
	
secondary_loops:

	; if a array has length 0, all elements of the remaining array that
	; contains elements are added to the final array

	; if the first array is large
	cmp r11, rsi
	jl lengt1_large

	; if the first array is large
	cmp r12, rcx
	jl lengt2_large

	jmp ending

lengt1_large:

	; add all the elements from the first array to the final array
	; v[size++] = v1[i++]
	xor edi, edi
	mov dword edi, [rax + r11 * 4]
	mov dword [r8 + r13 * 4], edi
	inc r13
	inc r11

	; continue the iteration
	jmp secondary_loops	

lengt2_large:

	; add all the elements from the first array to the final array
	; v[size++] = v2[j++]
	xor edi, edi
	mov dword edi, [rdx + r12 * 4]
	mov dword [r8 + r13 * 4], edi
	inc r13
	inc r12

	; continue the iteration
	jmp secondary_loops	

ending:
	leave
	ret
