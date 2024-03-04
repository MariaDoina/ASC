.data
	n: .long 35
	d: .long 0
	printPrim: .asciz "%d este numar prim.\n"
 	printNeprim: .asciz "%d nu este numar prim"
.text

.global main
main:
	mov $1, %ecx
	
loop:
	cmp n, %ecx
	jg et_verif
	
	mov n, %eax
	mov %ecx, %ebx
	mov $0, %edx
	div %ebx
	
	cmp $0, %edx
	je adauga
	

elem_urm:
	inc %ecx
	jmp loop
	
adauga:
	mov d, %eax
	add $1, %eax
	mov %eax, d
	jmp elem_urm
	
et_verif:
	mov d, %eax
	cmp $2, %eax
	je prim
	
	jmp neprim

prim:
	push n
	push $printPrim
	call printf
	pop %ebx
	pop %ebx
	
	push $0
	call fflush
	pop %ebx
	jmp et_exit
	
neprim:
	push n
	push $printNeprim
	call printf
	pop %ebx
	pop %ebx
	
	push $0
	call fflush
	pop %ebx
	jmp et_exit

et_exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
