.data
matrix: .space 1600
matrix2: .space 1600
i: .space 4 #index linie
j: .space 4 #index coloana
k: .space 4
nLine: .space 4 #dimensiunea matricei bordate
mCols: .space 4 #dimensiunea matricei bordate
nLine1: .space 4 #dimensiunea matricei -1
mCols1: .space 4 ##dimensiunea matricei -1
p: .space 4
index: .space 4
left: .space 4
right: .space 4
kEvol: .space 4
veciniVii: .space 4
formatScanf: .asciz "%d"
formatPrintf: .asciz "%d "
endl: .asciz "\nLine"

.text

et_copy_matrix:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %edi
	pushl %esi

	movl 12(%ebp), %edi
	movl 16(%ebp), %esi

	movl 8(%ebp), %eax

	xorl %ecx, %ecx

for_copy_matrix:
	cmp %ecx, %eax
	je et_eliberare
	movl (%esi, %ecx, 4), %edx
	movl %edx, (%edi, %ecx, 4)

	incl %ecx
	jmp for_copy_matrix
	
et_eliberare:
	popl %esi
	popl %edi
	popl %ebx
	popl %ebp
	ret

.global main

main:
	pushl $nLine
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $mCols
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $p
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	addl $2, mCols
	addl $2, nLine

movl $0, index

et_for:
	movl index, %ecx
	cmp %ecx, p
	je et_evol

	pushl $left
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	incl left

	pushl $right
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	incl right

	movl left, %eax
	movl $0, %edx
	mull mCols
	addl right, %eax
	lea matrix, %edi
	movl $1, (%edi, %eax, 4)

	incl index
	jmp et_for

et_evol:
	pushl $kEvol
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

movl $1,i
movl $1,j
movl $0,k

for_k:
	movl k, %ecx
	cmp %ecx, kEvol
	je et_afisare

	pushl $matrix
	pushl $matrix2
	pushl $400
	call et_copy_matrix
	popl %ebx
	popl %ebx
	popl %ebx

	movl $1, i

for_nLines1:
	movl i, %ecx
	incl %ecx
	cmp %ecx, nLine
	je et_cont1
	movl $1, j

for_mCols1:
	movl j, %ecx
	incl %ecx
	cmp %ecx, mCols
	je et_cont

	movl $0, veciniVii
	jmp vecin_stanga_sus


vecin_stanga_sus:
	decl i
	decl j

	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	incl i
	incl j

	lea matrix2, %edi
	movl (%edi,%eax,4), %ebx
	addl %ebx, veciniVii

	jmp vecin_sus

vecin_sus:
	decl i

	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	incl i

	lea matrix2, %edi
	movl (%edi,%eax,4), %ebx
	addl %ebx, veciniVii
	jmp vecin_dreapta_sus

vecin_dreapta_sus:
	decl i
	incl j

	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	incl i
	decl j

	lea matrix2, %edi
	movl (%edi,%eax,4), %ebx
	addl %ebx, veciniVii
	jmp vecin_stanga

vecin_stanga:
	incl j

	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	decl j

	lea matrix2, %edi

	movl (%edi,%eax,4), %ebx
	addl %ebx, veciniVii
	jmp vecin_dreapta

vecin_dreapta:
	incl i
	incl j

	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	decl i
	decl j

	lea matrix2, %edi
	movl (%edi,%eax,4), %ebx
	addl %ebx, veciniVii
	jmp vecin_stanga_jos

vecin_stanga_jos:
	incl i

	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	decl i

	lea matrix2, %edi
	movl (%edi,%eax,4), %ebx
	addl %ebx, veciniVii
	jmp vecin_jos

vecin_jos:
	incl i
	decl j

	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	decl i
	incl j

	lea matrix2, %edi
	movl (%edi,%eax,4), %ebx
	addl %ebx, veciniVii
	jmp vecin_dreapta_jos

vecin_dreapta_jos:
	decl j

	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	incl j

	lea matrix2, %edi
	movl (%edi,%eax,4), %ebx
	addl %ebx, veciniVii
	jmp et_celula

et_celula:

	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	lea matrix, %edi
	cmpl $0,(%edi,%eax,4)
	je et_celuleVii
	jmp et_celuleVii1

et_celuleVii1:
	movl veciniVii, %ebx
	movl $2, %eax
	movl $3, %edx

	cmp %eax, %ebx
	jl et_celula_moarta

	cmp %eax, %ebx
	je et_celula_vie

	cmp %edx, %ebx
	je et_celula_vie

	cmp %edx, %ebx
	jg et_celula_moarta

et_celuleVii:
	movl veciniVii, %ebx
	movl $3, %edx
	cmp %edx, %ebx
	je et_celula_vie

	cmp %edx, %ebx
	jne et_celula_moarta

et_celula_moarta:
	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	lea matrix, %edi
	movl $0, (%edi, %eax, 4)

	incl j
	jmp for_mCols1

et_celula_vie:
	movl i, %eax
	movl $0, %edx
	mull mCols
	addl j, %eax

	lea matrix, %edi
	movl $1, (%edi, %eax, 4)

	incl j
	jmp for_mCols1

et_cont:
	incl i
	jmp for_nLines1

et_cont1:
	incl k
	jmp for_k

et_afisare:
	movl nLine, %eax
	decl %eax
	movl %eax, nLine1

	movl mCols, %eax
	decl %eax
	movl %eax, mCols1
movl $1, i

	for_lines:
		movl i, %ecx
		cmp %ecx, nLine1
		je exit

		movl $1, j
	for_cols:
		movl j, %ecx
		cmp %ecx, mCols1
		je cont

		movl i, %eax
		movl $0, %edx
		mull mCols
		addl j, %eax

		lea	matrix, %edi

		movl (%edi, %eax, 4), %ebx

		pushl %ebx
		pushl $formatPrintf
		call printf
		popl %ebx
		popl %ebx

		pushl $0
		call fflush
		popl %ebx

		incl j
		jmp for_cols

	cont:
		movl $4, %eax
		movl $1, %ebx
		movl $endl, %ecx
		movl $1, %edx
		int $0x80

		incl i
		jmp for_lines


exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
