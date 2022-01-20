section .text
	global sort

; struct of a node
struc node 
	.val resd 1
	.next resd 1
endstruc


sort:
	enter 0, 0
	mov edi, [ebp + 8]		; size of the array with nodes
   	mov esi, [ebp + 12]		; the address of array

	;	initialization of the counter used for integration through the initial loop
	xor ebx, ebx
	mov ebx, 1		; 		; 1 2 3 4 ................. n
for1_n:

	xor ecx, ecx 		; node[0], node[1],  .... node[n]
for_elemente_array:

	xor edx, edx
	cmp [esi + node_size * ecx + node.val], ebx
	je for_urmatorul_element


	; continua iteratia for-ului prin array-ul de noduri
	inc ecx
	cmp ecx, edi
	jl for_elemente_array

	; continua iteratia for-ului de la 1 -> n
	inc ebx
	cmp ebx, edi
	jle for1_n



for_urmatorul_element:

	xor eax, eax
	mov eax, ebx
	inc eax 
	cmp eax, [esi + node_size * edx + node.val]
	je leaga_pointerii


	inc edx
	cmp edx, edi 		; trebuie pana la edi - 1
	jl for_urmatorul_element

	; continua iteratia for-ului prin array
	inc ecx
	cmp ecx, edi
	jl for_elemente_array

	; continua iteratia for-ului de la 1 -> n
	inc ebx
	cmp ebx, edi
	jle for1_n
	



leaga_pointerii:


	push eax
	xor eax, eax
	lea eax, [esi + node_size * edx]
	mov [esi + node_size * ecx + node.next], eax
	


	pop eax
	inc edx
	cmp edx, edi 		; trebuie pana la edi - 1
	jl for_urmatorul_element

	; continua iteratia for-ului prin array
	inc ecx
	cmp ecx, edi
	jl for_elemente_array

	; continua iteratia for-ului de la 1 -> n
	inc ebx
	cmp ebx, edi
	jle for1_n
	


; de aici adauga in head valoarea 1
	xor ecx, ecx
loop_final:

	; head = nodul cu valoare 1
	xor edx, edx
	mov dword edx, [esi + node_size * ecx + node.val]
	cmp edx, 1
	je put_head_one;
	inc ecx
	cmp ecx, edi 
	jle loop_final
	jmp final
	
put_head_one:

	xor eax, eax
	lea eax, [esi + node_size * ecx]


final:
	leave
	ret

