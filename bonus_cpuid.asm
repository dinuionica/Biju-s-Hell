section .text
	global cpu_manufact_id
	global features
	global l2_cache_info

; reads the manufacturer id string from cpuid and stores it in id_string
cpu_manufact_id:
	enter 	0, 0
	; adding parameters on the stack to keep them unchanged
	pushad
	
	; call cpuid
	xor eax, eax
	cpuid
	
	; adding the id string the parameter transmitted to the function
	mov eax, [ebp + 8]
	; the first 4 characters
	mov dword [eax + 0], ebx
	; the next 4 characters
	mov dword [eax + 4], edx
	; last 4 characters
	mov dword [eax + 8], ecx	

	jmp ending


; checks whether vmx, rdrand and avx are supported by the cpu
; if a feature is supported, 1 is written in the corresponding variable
; 0 is written otherwise
features:
	enter 	0, 0
	; adding parameters on the stack to keep them unchanged
	pushad
	; call cpuid
	mov eax, 1
	cpuid

	; to test the existence of vmx it is checked if 
	; the fifth bit of the ecx register is set
	mov esi, [ebp + 8]
	mov dword [esi], 0
	test ecx, 0x20
	jnz vmx_existing

	; continue a new check
	jz rdrand_cheking

vmx_existing:

	; adding the value 1 for the parameter
	mov dword [esi], 1

rdrand_cheking:

	; to test the existence of rdrand it is checked if 
	; the 30 bit of the ecx register is set
	mov edx, [ebp + 12]
	mov dword [edx], 0
	test ecx, 0x40000000
	jnz rdrand_existing

	; continue a new check
	jz vax_cheking

rdrand_existing:

	; adding the value 1 for the parameter
	mov dword [edx], 1

vax_cheking:
	
	; to test the existence of vax it is checked if 
	; the 28 bit of the ecx register is set
	mov edi, [ebp + 16]
	mov dword [edi], 0
	test ecx, 0x10000000
	jnz vax_existing
	jz ending

vax_existing:

	; adding the value 1 for the parameter
    mov dword [edi], 1

ending:

	popad
	leave
	ret
	
;  reads from cpuid the cache line size, and total cache size for the current
;  cpu, and stores them in the corresponding parameters
l2_cache_info:
	enter 	0, 0
	; adding parameters on the stack to keep them unchanged
	pushad
	; call cpu
	xor eax, eax
	mov eax, 80000006h
	cpuid

	; add the ecx register to the stack to keep it unchanged
	push ecx
	
	; within the first 8 bits is the value of the cache size line
	and ecx, 0xff

	; adding value of the line size within the parameter
	mov edx, [ebp + 8]
	mov dword [edx], ecx

	pop ecx

	; 16 bits are shifted and the last 16 bits represent the total cache size
	sar ecx, 16 
	and ecx, 0xffff

	; adding value of the size within the parameter	
	mov esi, [ebp + 12]
	mov dword [esi], ecx

	popad
	leave
	ret
