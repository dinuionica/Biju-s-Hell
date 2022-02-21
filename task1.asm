section .text
	global sort

; the struct of a node
struc node 
	.val resd 1
	.next resd 1
endstruc

sort:

	enter 0, 0
	; size of the array with nodes
	mov edi, [ebp + 8]	
	; the address of the array
   	mov esi, [ebp + 12]

	; initializing the counter used to search for numbers from 1 to n
	; 1 2 3 4 ......... n
	xor ebx, ebx
	mov ebx, 1

search_number:

	; initializing the counter used to search for iteration through nodes
	; node[0], node[1], .......... node[n]
	xor ecx, ecx 

iteration_array:

	; if the first item with the desired value is found,
	; then the consecutive item is searched
	xor edx, edx
	cmp [esi + node_size * ecx + node.val], ebx
	je find_next_element

	; if not found, continue the iteration through the node array
	inc ecx
	cmp ecx, edi
	jl iteration_array

	; continue the iteration for numbers
	inc ebx
	cmp ebx, edi
	jle search_number

find_next_element:

	; if the desired consecutive element is found (element + 1)
	; is made the connection of the next pointer 
	mov eax, ebx
	inc eax 
	cmp eax, [esi + node_size * edx + node.val]
	je connect_address


	; continue searching for the next item
	inc edx
	cmp edx, edi 		
	jl find_next_element

	; if not found, continue the iteration through the node array
	inc ecx
	cmp ecx, edi
	jl iteration_array


	; continue the iteration for numbers
	inc ebx
	cmp ebx, edi
	jle search_number
	
connect_address:

	; in the eax register is obtained the address of the consecutive
	; element and then the connection of the next pointer of the 
	; current element is made to the consecutive element 
	push eax
	lea eax, [esi + node_size * edx]
	mov [esi + node_size * ecx + node.next], eax
	

	; getting the item on the stack
	pop eax

	; continue searching for the next item
	inc edx
	cmp edx, edi
	jl find_next_element

	; continue the iteration through the node array
	inc ecx
	cmp ecx, edi
	jl iteration_array

	; continue the iteration for numbers
	inc ebx
	cmp ebx, edi
	jle search_number
	
	; resetting the ecx counter to the final iteration
	xor ecx, ecx

final_iteration:

	; looking for the node that contains the element with value 1
	mov dword edx, [esi + node_size * ecx + node.val]
	cmp edx, 1
	je head_update;

	; continue the final iteration
	inc ecx
	cmp ecx, edi 
	jle final_iteration
	jmp ending
	
head_update:

	; if the item with value 1 was found, its 
	; address is added to the eax register for return the head
	lea eax, [esi + node_size * ecx]

ending:
	; free the stack and return 
	leave
	ret
