.data
	vector: .long 10, 10, 9
	n: .long 3
	cat: .space 4
	rest: .space 4
	
	formatPrint: .asciz "Media este %d, rest %d"

.text

.global main
main:
	lea vector, %edi
	mov $0, %eax
	mov $0, %ecx
	
	
et_for:
	cmp %ecx, n
	je et_imp

	mov (%edi, %ecx, 4), %ebx
	add %ebx, %eax
	
	inc %ecx
	jmp et_for

et_imp:
	mov $0, %edx
	divl n
	mov %eax, cat
	mov %edx, rest
	
	push rest
	push cat
	push $formatPrint
	call printf
	pop %ebx
	pop %ebx
	pop %ebx
	
	push $0
	call fflush
	pop %ebx

et_exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
