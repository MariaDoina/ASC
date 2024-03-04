.data
	str: .asciz "Hello World!"
.text
.global main
main:
	mov $4, %eax
	mov $1, %ebx
	mov $str, %ecx
	mov $12, %edx
	int $0x80

et_exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
