#Simple code that calculates the addition, subtraction, multiplication and division of 2 numbers
.data
	x: .long 30
	y: .long 7
	sum: .space 4
	dif: .space 4
	prod: .space 4
	cat: .space 4
	rest: .space 4
.text
.global main
main:
	mov x, %eax
	add y, %eax
	mov %eax, sum

	mov x, %eax
	sub y, %eax
	mov %eax, dif

	mov x, %eax
	mov y, %ebx
	mul %ebx
	mov %eax, prod

	mov x, %eax
	mov y, %ebx
	mov $0, %edx
	div %ebx
	mov %eax, cat
	mov %edx, rest

	mov $1, %eax
	mov $0, %ebx
	int $0x80
