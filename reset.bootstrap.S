exit:
	pushl %ebp
	movl %esp, %ebp
	movl $1, %eax
	pushl %eax
	movl 8(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	int $0x80
	leave
	ret
read:
	pushl %ebp
	movl %esp, %ebp
	movl $3, %eax
	pushl %eax
	movl 8(%ebp), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, %ecx
	movl 16(%ebp), %eax
	movl %eax, %edx
	popl %eax
	int $0x80
	leave
	ret
write:
	pushl %ebp
	movl %esp, %ebp
	movl $4, %eax
	pushl %eax
	movl 8(%ebp), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, %ecx
	movl 16(%ebp), %eax
	movl %eax, %edx
	popl %eax
	int $0x80
	leave
	ret
open:
	pushl %ebp
	movl %esp, %ebp
	movl $5, %eax
	pushl %eax
	movl 8(%ebp), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, %ecx
	movl 16(%ebp), %eax
	movl %eax, %edx
	popl %eax
	int $0x80
	leave
	ret
close:
	pushl %ebp
	movl %esp, %ebp
	movl $6, %eax
	pushl %eax
	movl 8(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	int $0x80
	leave
	ret
brk:
	pushl %ebp
	movl %esp, %ebp
	movl $45, %eax
	pushl %eax
	movl 8(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	int $0x80
	leave
	ret
munmap:
	pushl %ebp
	movl %esp, %ebp
	movl $91, %eax
	pushl %eax
	movl 8(%ebp), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, %ecx
	popl %eax
	int $0x80
	leave
	ret
mmap2:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebp
	movl $192, %eax
	pushl %eax
	movl 8(%ebp), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, %ecx
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl 20(%ebp), %eax
	movl %eax, %esi
	movl 24(%ebp), %eax
	movl %eax, %edi
	movl 28(%ebp), %eax
	movl %eax, %ebp
	popl %eax
	int $0x80
	popl %ebp
	leave
	ret
getcwd:
	pushl %ebp
	movl %esp, %ebp
	movl $183, %eax
	pushl %eax
	movl 8(%ebp), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, %ecx
	popl %eax
	int $0x80
	leave
	ret
align:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	addl %ebx, %eax
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	pushl %ebx
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	notl %eax
	andl %ebx, %eax
	leave
	ret
align_down:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	pushl %eax
	movl 8(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	movl 12(%ebp), %eax
	pushl %ebx
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	andl %ebx, %eax
	popl %ebx
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	leave
	ret
.data
itoa_digits:.long strbuf+0
.text
itoa:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movl itoa_digits, %eax
	pushl %edx
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	pushl %eax
	movl 16(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	cltd
	idivl %ebx
	movl %edx, %eax
	popl %edx
	addl %eax, %edx
	movsbl (%edx), %eax
	popl %edx
	movb %al, (%edx)
	movl 8(%ebp), %eax
	pushl %eax
	movl 16(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	cltd
	idivl %ebx
	movl %eax, 8(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
_label0:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label1
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movl itoa_digits, %eax
	pushl %edx
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	pushl %eax
	movl 16(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	cltd
	idivl %ebx
	movl %edx, %eax
	popl %edx
	addl %eax, %edx
	movsbl (%edx), %eax
	popl %edx
	movb %al, (%edx)
	movl 8(%ebp), %eax
	pushl %eax
	movl 16(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	cltd
	idivl %ebx
	movl %eax, 8(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label0
_label1:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movl $0, %eax
	movb %al, (%edx)
_label2:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label3
	movl -4(%ebp), %eax
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -8(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, -12(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -8(%ebp), %eax
	addl %eax, %edx
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	popl %edx
	movb %al, (%edx)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movl -12(%ebp), %eax
	movb %al, (%edx)
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -8(%ebp)
	jmp _label2
_label3:
	movl 12(%ebp), %eax
	leave
	ret
.data
free_start:.long 0
free_end:.long 0
.text
allocate_new_page:
	pushl %ebp
	movl %esp, %ebp
	movl free_end, %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label4
	subl $4, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	call brk
	addl $4, %esp
	movl %eax, free_end
	movl free_end, %eax
	movl %eax, free_start
_label4:
	subl $4, %esp
	movl free_end, %eax
	pushl %ebx
	movl %eax, %ebx
	movl $4096, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, 0(%esp)
	call brk
	addl $4, %esp
	movl %eax, free_end
	leave
	ret
malloc:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
_label5:
	movl free_start, %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	addl %ebx, %eax
	movl %eax, %edx
	movl free_end, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label6
	call allocate_new_page
	jmp _label5
_label6:
	movl free_start, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	addl %ebx, %eax
	movl %eax, free_start
	movl -4(%ebp), %eax
	leave
	ret
free:
	pushl %ebp
	movl %esp, %ebp
	leave
	ret
calloc:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call malloc
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $12, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl 8(%ebp), %eax
	movl %eax, 8(%esp)
	call memset
	addl $12, %esp
	movl -4(%ebp), %eax
	leave
	ret
realloc:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, -4(%ebp)
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label7
	movl 16(%ebp), %eax
	movl %eax, -4(%ebp)
_label7:
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, 0(%esp)
	call calloc
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call memcpy
	addl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	movl -8(%ebp), %eax
	leave
	ret
memset:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
_label8:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl 16(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label9
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movl 8(%ebp), %eax
	movb %al, (%edx)
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label8
_label9:
	leave
	ret
memcpy:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
_label10:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl 16(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label11
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	popl %edx
	movb %al, (%edx)
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label10
_label11:
	leave
	ret
strlen:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
_label12:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label13
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label12
_label13:
	movl -4(%ebp), %eax
	leave
	ret
stresclen:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
_label14:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label15
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, %edx
	movl $92, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label16
	movl 8(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, 8(%ebp)
_label16:
	movl 8(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, 8(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label14
_label15:
	movl -4(%ebp), %eax
	leave
	ret
strcpy:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, -8(%ebp)
_label17:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label18
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movl -8(%ebp), %eax
	movb %al, (%edx)
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, -8(%ebp)
	jmp _label17
_label18:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movl $0, %eax
	movb %al, (%edx)
	movl -4(%ebp), %eax
	leave
	ret
strcmp:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, -8(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, -12(%ebp)
_label19:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label20
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl -12(%ebp), %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label21
	movl -8(%ebp), %eax
	pushl %eax
	movl -12(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	leave
	ret
_label21:
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, -8(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -4(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, -12(%ebp)
	jmp _label19
_label20:
	movl -8(%ebp), %eax
	pushl %eax
	movl -12(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	leave
	ret
strdup:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call strlen
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl -4(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, 0(%esp)
	call calloc
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call memcpy
	addl $12, %esp
	movl -8(%ebp), %eax
	leave
	ret
strlitdup:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call strlen
	addl $4, %esp
	pushl %eax
	movl $2, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl -4(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, 0(%esp)
	call calloc
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call memcpy
	addl $12, %esp
	movl -8(%ebp), %eax
	leave
	ret
allocate_tuple:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $4, %eax
	pushl %ebx
	movl %eax, %ebx
	movl 8(%ebp), %eax
	imull %ebx, %eax
	popl %ebx
	movl %eax, 0(%esp)
	call malloc
	addl $4, %esp
	leave
	ret
tuple1:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl $1, %eax
	movl %eax, 0(%esp)
	call allocate_tuple
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
tuple2:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl $2, %eax
	movl %eax, 0(%esp)
	call allocate_tuple
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
tuple3:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl $3, %eax
	movl %eax, 0(%esp)
	call allocate_tuple
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 16(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
tuple4:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl $4, %eax
	movl %eax, 0(%esp)
	call allocate_tuple
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 16(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 20(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
tuple5:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl $5, %eax
	movl %eax, 0(%esp)
	call allocate_tuple
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 16(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 20(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 24(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
tuple6:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl $6, %eax
	movl %eax, 0(%esp)
	call allocate_tuple
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 16(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 20(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 24(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 28(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
tuple7:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl $7, %eax
	movl %eax, 0(%esp)
	call allocate_tuple
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 16(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 20(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 24(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 28(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 32(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
tuple8:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl $8, %eax
	movl %eax, 0(%esp)
	call allocate_tuple
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 16(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 20(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 24(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 28(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 32(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $7, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 36(%ebp), %eax
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
list:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	call list_insert
	addl $8, %esp
	leave
	ret
list_insert:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call tuple2
	addl $8, %esp
	leave
	ret
list_next:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
list_value:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
list_pop:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call list_next
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	movl -4(%ebp), %eax
	leave
	ret
char_vector:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	call calloc
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
vector:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl $4, %eax
	pushl %ebx
	movl %eax, %ebx
	movl 12(%ebp), %eax
	imull %ebx, %eax
	popl %ebx
	movl %eax, 0(%esp)
	call calloc
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
vector_buffer:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
vector_size:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
char_vector_reserve:
	pushl %ebp
	movl %esp, %ebp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label22
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	pushl %ebx
	subl $12, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	call realloc
	addl $12, %esp
	popl %ebx
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
_label22:
	leave
	ret
vector_reserve:
	pushl %ebp
	movl %esp, %ebp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label23
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	pushl %ebx
	subl $12, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	pushl %ebx
	movl %eax, %ebx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	imull %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	movl $4, %eax
	pushl %ebx
	movl %eax, %ebx
	movl 12(%ebp), %eax
	imull %ebx, %eax
	popl %ebx
	movl %eax, 8(%esp)
	call realloc
	addl $12, %esp
	popl %ebx
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
_label23:
	leave
	ret
char_vector_resize:
	pushl %ebp
	movl %esp, %ebp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label24
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call char_vector_reserve
	addl $8, %esp
_label24:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	leave
	ret
vector_resize:
	pushl %ebp
	movl %esp, %ebp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label25
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_reserve
	addl $8, %esp
_label25:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	leave
	ret
char_vector_get:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	leave
	ret
vector_get:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %edx
	movl 12(%ebp), %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
char_vector_set:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	addl %eax, %edx
	movl 16(%ebp), %eax
	movb %al, (%edx)
	leave
	ret
vector_set:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 16(%ebp), %eax
	movl %eax, (%ebx)
	leave
	ret
char_vector_push:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label26
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $2, %eax
	imull %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call char_vector_reserve
	addl $8, %esp
_label26:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	call char_vector_set
	addl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	leave
	ret
vector_push:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label27
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $2, %eax
	imull %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call vector_reserve
	addl $8, %esp
_label27:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	call vector_set
	addl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	leave
	ret
char_vector_pop:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call char_vector_get
	addl $8, %esp
	leave
	ret
vector_pop:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	leave
	ret
vector_destroy:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	leave
	ret
.data
stdin:.long 0
stdout:.long 0
stderr:.long 0
.text
input_chan:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl $512, %eax
	movl %eax, 0(%esp)
	call malloc
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $20, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl $0, %eax
	movl %eax, 12(%esp)
	movl $0, %eax
	movl %eax, 16(%esp)
	call tuple5
	addl $20, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	leave
	ret
input_chan_file:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	call open
	addl $12, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	popl %edx
	setg %al
	movzbl %al, %eax
	movl %eax, 0(%esp)
	movl $strbuf+37, %eax
	movl %eax, 4(%esp)
	call assert
	addl $8, %esp
	subl $4, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	call input_chan
	addl $4, %esp
	leave
	ret
input_chan_close:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call close
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	leave
	ret
output_chan:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl $512, %eax
	movl %eax, 0(%esp)
	call malloc
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	leave
	ret
output_chan_file:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	pushl %ebx
	movl %eax, %ebx
	movl $64, %eax
	orl %ebx, %eax
	popl %ebx
	pushl %ebx
	movl %eax, %ebx
	movl $512, %eax
	orl %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	movl $420, %eax
	movl %eax, 8(%esp)
	call open
	addl $12, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	popl %edx
	setg %al
	movzbl %al, %eax
	movl %eax, 0(%esp)
	movl $strbuf+70, %eax
	movl %eax, 4(%esp)
	call assert
	addl $8, %esp
	subl $4, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	call output_chan
	addl $4, %esp
	leave
	ret
output_chan_close:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call flush
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call close
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	leave
	ret
initialize_io:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	call input_chan
	addl $4, %esp
	movl %eax, stdin
	subl $4, %esp
	movl $1, %eax
	movl %eax, 0(%esp)
	call output_chan
	addl $4, %esp
	movl %eax, stdout
	subl $4, %esp
	movl $2, %eax
	movl %eax, 0(%esp)
	call output_chan
	addl $4, %esp
	movl %eax, stderr
	leave
	ret
fill:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	cmpl $0, %eax
	je _label28
	leave
	ret
_label28:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label29
	subl $12, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl $512, %eax
	movl %eax, 8(%esp)
	call read
	addl $12, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $0, %eax
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label30
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $1, %eax
	movl %eax, (%ebx)
_label30:
_label29:
	leave
	ret
fgetc:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call fill
	addl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label31
	movl $1, %eax
	negl %eax
	leave
	ret
_label31:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
getc:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl stdin, %eax
	movl %eax, 0(%esp)
	call fgetc
	addl $4, %esp
	leave
	ret
fnextc:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call fill
	addl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	addl %ebx, %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label32
	movl $1, %eax
	negl %eax
	leave
	ret
_label32:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	addl %ebx, %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	leave
	ret
nextc:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl stdin, %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	call fnextc
	addl $8, %esp
	leave
	ret
flush:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label33
	subl $12, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 8(%esp)
	call write
	addl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $0, %eax
	movl %eax, (%ebx)
_label33:
	leave
	ret
fputc:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	addl %eax, %edx
	movl 12(%ebp), %eax
	movb %al, (%edx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $512, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label34
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call flush
	addl $4, %esp
	leave
	ret
_label34:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $10, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label35
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call flush
	addl $4, %esp
	leave
	ret
_label35:
	leave
	ret
putc:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl stdout, %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
eputc:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl stderr, %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
fputs:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, -4(%ebp)
_label36:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label37
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, 12(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	addl %eax, %edx
	movsbl (%edx), %eax
	movl %eax, -4(%ebp)
	jmp _label36
_label37:
	leave
	ret
puts:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl stdout, %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
eputs:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl stderr, %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
.data
fputn_buffer:.long 0
.text
fputn:
	pushl %ebp
	movl %esp, %ebp
	movl fputn_buffer, %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label38
	subl $4, %esp
	movl $33, %eax
	movl %eax, 0(%esp)
	call malloc
	addl $4, %esp
	movl %eax, fputn_buffer
_label38:
	subl $12, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl fputn_buffer, %eax
	movl %eax, 4(%esp)
	movl $33, %eax
	movl %eax, 8(%esp)
	call memset
	addl $12, %esp
	subl $12, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl fputn_buffer, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call itoa
	addl $12, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl fputn_buffer, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
fputd:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $10, %eax
	movl %eax, 8(%esp)
	call fputn
	addl $12, %esp
	leave
	ret
fputx:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $16, %eax
	movl %eax, 8(%esp)
	call fputn
	addl $12, %esp
	leave
	ret
putd:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl stdout, %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $10, %eax
	movl %eax, 8(%esp)
	call fputn
	addl $12, %esp
	leave
	ret
putx:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl stdout, %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $16, %eax
	movl %eax, 8(%esp)
	call fputn
	addl $12, %esp
	leave
	ret
eputd:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl stderr, %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $10, %eax
	movl %eax, 8(%esp)
	call fputn
	addl $12, %esp
	leave
	ret
eputx:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl stderr, %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $16, %eax
	movl %eax, 8(%esp)
	call fputn
	addl $12, %esp
	leave
	ret
assert:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	cmpl $0, %eax
	je _label39
	leave
	ret
_label39:
	subl $4, %esp
	movl $strbuf+104, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	movl 12(%ebp), %eax
	cmpl $0, %eax
	je _label41
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	jmp _label40
_label41:
	subl $4, %esp
	movl $strbuf+113, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
_label40:
	subl $4, %esp
	movl $10, %eax
	movl %eax, 0(%esp)
	call eputc
	addl $4, %esp
	subl $4, %esp
	movl $1, %eax
	movl %eax, 0(%esp)
	call exit
	addl $4, %esp
	leave
	ret
.data
char_table:.long 0,1,1,1,1,1,1,1,1,2,3,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,14,12,14,14,14,14,11,14,14,14,14,14,14,14,14,4,5,5,5,5,5,5,5,6,6,14,14,14,14,14,14,14,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,14,13,14,14,7,14,9,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,10,8,8,14,14,14,14,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
char_to_escape:.long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34,0,0,0,0,39,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,92,0,0,0,0,7,8,0,0,27,12,0,0,0,0,0,0,0,10,0,0,0,13,0,9,0,11,0,0,0,0,0,0,0,0,0
reserved_keywords:.long strbuf+130,strbuf+133,strbuf+138,strbuf+144,strbuf+153,strbuf+156,strbuf+160,strbuf+166,strbuf+175,strbuf+179,strbuf+186,strbuf+194,strbuf+201,strbuf+206,strbuf+212,strbuf+221,strbuf+231,strbuf+236,strbuf+240,strbuf+248,0
lx00n:.long lx01,le00,lx00,lx00,lx02,lx06,lx06,lx07,lx07,lx09,lx09,lx11,lx15,le00,lx18
lx02n:.long lx99,le00,lx99,lx99,le01,lx03,le02,le03,le00,le03,lx04,le00,le00,le00,lx99
lx03n:.long lx99,le00,lx99,lx99,lx03,lx03,le02,le03,le00,le03,le00,le00,le00,le00,lx99
lx04n:.long le04,le00,le04,le04,lx05,lx05,lx05,lx05,le00,lx05,le00,le00,le00,le00,le00
lx05n:.long lx99,le00,lx99,lx99,lx05,lx05,lx05,lx05,le00,lx05,le00,le00,le00,le00,lx99
lx06n:.long lx99,le00,lx99,lx99,lx06,lx06,lx06,le05,le00,le05,le00,le00,le00,le00,lx99
lx07n:.long lx08,le00,lx08,lx08,lx07,lx07,lx07,lx07,lx07,lx07,lx07,le00,le00,le00,lx08
lx09n:.long lx08,le00,lx08,lx08,lx10,lx10,lx10,lx07,lx07,lx07,lx07,le00,le00,le00,lx08
lx10n:.long lx99,le00,lx99,lx99,lx10,lx10,lx10,lx07,lx07,lx07,lx07,le00,le00,le00,lx99
lx11n:.long le06,le00,lx12,le06,lx12,lx12,lx12,lx12,lx12,lx12,lx12,lx12,lx12,lx13,lx12
lx15n:.long le07,le00,lx15,le07,lx15,lx15,lx15,lx15,lx15,lx15,lx15,lx15,lx17,lx16,lx15
lx16n:.long le07,le00,lx15,le07,lx15,lx15,lx15,lx15,lx15,lx15,lx15,lx15,lx17,lx16,lx15
.text
lexer:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call char_vector
	addl $8, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	call char_vector_push
	addl $8, %esp
	subl $32, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $1, %eax
	movl %eax, 8(%esp)
	movl $1, %eax
	movl %eax, 12(%esp)
	movl $0, %eax
	movl %eax, 16(%esp)
	movl $0, %eax
	movl %eax, 20(%esp)
	movl $0, %eax
	movl %eax, 24(%esp)
	movl -4(%ebp), %eax
	movl %eax, 28(%esp)
	call tuple8
	addl $32, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	leave
	ret
lexer_file:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call input_chan_file
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	movl %eax, 4(%esp)
	call lexer
	addl $8, %esp
	leave
	ret
lexer_destroy:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $7, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_destroy
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call input_chan_close
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	leave
	ret
lexer_look:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	call fnextc
	addl $8, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	negl %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label42
	movl $0, %eax
	leave
	ret
_label42:
	movl -4(%ebp), %eax
	leal char_table(,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
lexer_consume:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call fgetc
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $10, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label43
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $0, %eax
	movl %eax, (%ebx)
_label43:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	subl $12, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $7, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_token_length
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	pushl %ebx
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call char_vector_set
	addl $12, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $7, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	call char_vector_push
	addl $8, %esp
	movl -4(%ebp), %eax
	leave
	ret
lexer_token_set:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	leave
	ret
lexer_token_get:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
lexer_token_text:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $7, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_buffer
	addl $4, %esp
	leave
	ret
lexer_token_length:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $7, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	leave
	ret
lexer_token_value:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
lexer_token_location:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
lexer_hold:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	popl %edx
	sete %al
	movzbl %al, %eax
	movl %eax, 0(%esp)
	movl $strbuf+261, %eax
	movl %eax, 4(%esp)
	call assert
	addl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $1, %eax
	movl %eax, (%ebx)
	leave
	ret
lexer_reset_token:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $0, %eax
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $0, %eax
	movl %eax, (%ebx)
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $7, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	call char_vector_resize
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $7, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	call char_vector_push
	addl $8, %esp
	leave
	ret
fputloc:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl $58, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	subl $12, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl $10, %eax
	movl %eax, 8(%esp)
	call fputn
	addl $12, %esp
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl $58, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	subl $12, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl $10, %eax
	movl %eax, 8(%esp)
	call fputn
	addl $12, %esp
	leave
	ret
lexer_error:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_token_location
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	movl stderr, %eax
	movl %eax, 4(%esp)
	call fputloc
	addl $8, %esp
	subl $4, %esp
	movl $strbuf+294, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl $10, %eax
	movl %eax, 0(%esp)
	call eputc
	addl $4, %esp
	subl $4, %esp
	movl $1, %eax
	movl %eax, 0(%esp)
	call exit
	addl $4, %esp
	leave
	ret
lexer_lex:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	cmpl $0, %eax
	je _label44
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $0, %eax
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
_label44:
lx00:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label46
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label46
	movl $0, %eax
	jmp _label47
_label46:
	movl $1, %eax
_label47:
	cmpl $0, %eax
	je _label45
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl $lx00, %eax
	jmp *%eax
_label45:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_reset_token
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx00n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx01:
	movl $256, %eax
	leave
	ret
lx02:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $257, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx02n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx03:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $8, %eax
	imull %ebx, %eax
	popl %ebx
	pushl %ebx
	movl %eax, %ebx
	movl -4(%ebp), %eax
	pushl %ebx
	pushl %eax
	movl $48, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx03n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx04:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx04n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx05:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $97, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label49
	movl -4(%ebp), %eax
	pushl %eax
	movl $97, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	movl %eax, %ebx
	movl $10, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label48
_label49:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $65, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label51
	movl -4(%ebp), %eax
	pushl %eax
	movl $65, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	movl %eax, %ebx
	movl $10, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label50
_label51:
	movl -4(%ebp), %eax
	pushl %eax
	movl $48, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	movl %eax, -4(%ebp)
_label50:
_label48:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $16, %eax
	imull %ebx, %eax
	popl %ebx
	pushl %ebx
	movl %eax, %ebx
	movl -4(%ebp), %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx05n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx06:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $257, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $10, %eax
	imull %ebx, %eax
	popl %ebx
	pushl %ebx
	movl %eax, %ebx
	movl -4(%ebp), %eax
	pushl %ebx
	pushl %eax
	movl $48, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx06n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx07:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $258, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx07n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx08:
	movl $0, %eax
	movl %eax, -8(%ebp)
_label52:
	movl -8(%ebp), %eax
	leal reserved_keywords(,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label53
	subl $8, %esp
	movl -8(%ebp), %eax
	leal reserved_keywords(,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_token_text
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call strcmp
	addl $8, %esp
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label54
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $270, %eax
	pushl %ebx
	movl %eax, %ebx
	movl -8(%ebp), %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	movl $lx99, %eax
	jmp *%eax
_label54:
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -8(%ebp)
	jmp _label52
_label53:
	movl $lx99, %eax
	jmp *%eax
lx09:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl $261, %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $97, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label55
	movl $260, %eax
	movl %eax, -8(%ebp)
_label55:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx09n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx10:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $10, %eax
	imull %ebx, %eax
	popl %ebx
	pushl %ebx
	movl %eax, %ebx
	movl -4(%ebp), %eax
	pushl %ebx
	pushl %eax
	movl $48, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx10n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx11:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $257, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx11n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx12:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	movl %eax, (%ebx)
	movl $lx14, %eax
	jmp *%eax
lx13:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	leal char_to_escape(,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, (%ebx)
lx14:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	movl %eax, %edx
	movl $11, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label56
	movl $le06, %eax
	jmp *%eax
_label56:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl $lx99, %eax
	jmp *%eax
lx15:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx15n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx16:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	leal lx16n(,%eax,4), %eax
	movl (%eax), %eax
	jmp *%eax
lx17:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $259, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	movl $lx99, %eax
	jmp *%eax
lx18:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	call fnextc
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call fnextc
	addl $8, %esp
	movl %eax, -12(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label58
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label60
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $300, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	jmp _label59
_label60:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $62, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label59
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $304, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label59:
	jmp _label57
_label58:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $33, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label61
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label62
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $301, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label62:
	jmp _label57
_label61:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $43, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label63
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label65
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $309, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	jmp _label64
_label65:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $43, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label64
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $319, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label64:
	jmp _label57
_label63:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $45, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label66
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label68
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $310, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	jmp _label67
_label68:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $45, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label67
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $320, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label67:
	jmp _label57
_label66:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $42, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label69
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label70
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $311, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label70:
	jmp _label57
_label69:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $47, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label71
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label72
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $312, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label72:
	jmp _label57
_label71:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $37, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label73
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label74
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $313, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label74:
	jmp _label57
_label73:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $60, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label75
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label77
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $302, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	jmp _label76
_label77:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $60, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label76
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label79
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $317, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	jmp _label78
_label79:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $305, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label78:
_label76:
	jmp _label57
_label75:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $62, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label80
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label82
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $303, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	jmp _label81
_label82:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $62, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label81
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label84
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $318, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	jmp _label83
_label84:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $306, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label83:
_label81:
	jmp _label57
_label80:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $94, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label85
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label86
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $315, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label86:
	jmp _label57
_label85:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $38, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label87
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $38, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label89
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $307, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	jmp _label88
_label89:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label88
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $314, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label88:
	jmp _label57
_label87:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $124, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label90
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $124, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label92
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $308, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
	jmp _label91
_label92:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label91
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $316, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label91:
	jmp _label57
_label90:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $35, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label93
_label94:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $10, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label96
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label96
	movl $1, %eax
	jmp _label97
_label96:
	movl $0, %eax
_label97:
	cmpl $0, %eax
	je _label95
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call fgetc
	addl $4, %esp
	movl %eax, -4(%ebp)
	jmp _label94
_label95:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $1, %eax
	movl %eax, (%ebx)
	movl $lx00, %eax
	jmp *%eax
	jmp _label57
_label93:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $46, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label57
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $46, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label98
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $46, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label99
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $321, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label99:
_label98:
_label57:
lx99:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
le00:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+297, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le01:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+315, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le02:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+340, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le03:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+382, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le04:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+428, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le05:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+458, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le06:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+506, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le07:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+537, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
	leave
	ret
lexer_lex_asm:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
lax00:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label101
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label101
	movl $0, %eax
	jmp _label102
_label101:
	movl $1, %eax
_label102:
	cmpl $0, %eax
	je _label100
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl $lax00, %eax
	jmp *%eax
_label100:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_reset_token
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl %eax, -4(%ebp)
lax01:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $125, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label103
	movl $lae00, %eax
	jmp *%eax
_label103:
lax02:
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	call fnextc
	addl $8, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $125, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label104
	movl $lae00, %eax
	jmp *%eax
_label104:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label105
	movl $lax03, %eax
	jmp *%eax
_label105:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_consume
	addl $4, %esp
	movl $lax02, %eax
	jmp *%eax
lax03:
	movl $1, %eax
	movl %eax, -12(%ebp)
_label106:
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	pushl %edx
	leal 1(%eax), %edx
	movl %edx, -12(%ebp)
	popl %edx
	movl %eax, 4(%esp)
	call fnextc
	addl $8, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	negl %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label108
	movl $lae01, %eax
	jmp *%eax
_label108:
	movl -4(%ebp), %eax
	leal char_table(,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label109
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label109
	movl $0, %eax
	jmp _label110
_label109:
	movl $1, %eax
_label110:
	cmpl $0, %eax
	jne _label106
_label107:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $125, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	leave
	ret
lae00:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+565, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
lae01:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+597, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
	leave
	ret
parser:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call list
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	leave
	ret
parser_lexer:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call list_value
	addl $4, %esp
	leave
	ret
parser_buffer:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
parser_token_location:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_location
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	pushl %eax
	pushl %ebx
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_length
	addl $4, %esp
	popl %ebx
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
parser_include_search:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
_label111:
	movl -8(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label112
	subl $8, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call strcmp
	addl $8, %esp
	cmpl $0, %eax
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label113
	movl $1, %eax
	leave
	ret
_label113:
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -8(%ebp)
	jmp _label111
_label112:
	movl $0, %eax
	leave
	ret
parser_include_add:
	pushl %ebp
	movl %esp, %ebp
	movl 16(%ebp), %eax
	cmpl $0, %eax
	je _label115
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call parser_include_search
	addl $8, %esp
	cmpl $0, %eax
	je _label115
	movl $1, %eax
	jmp _label116
_label115:
	movl $0, %eax
_label116:
	cmpl $0, %eax
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label114
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	pushl %ebx
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_file
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call list_insert
	addl $8, %esp
	popl %ebx
	movl %eax, (%ebx)
	movl 16(%ebp), %eax
	cmpl $0, %eax
	je _label117
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
_label117:
_label114:
	leave
	ret
parser_lexer_hold:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_hold
	addl $4, %esp
	leave
	ret
parser_lex:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_lex
	addl $4, %esp
	leave
	ret
parser_lex_asm:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_lex_asm
	addl $4, %esp
	leave
	ret
parser_error:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl stderr, %eax
	movl %eax, 4(%esp)
	call fputloc
	addl $8, %esp
	subl $4, %esp
	movl $strbuf+294, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl $10, %eax
	movl %eax, 0(%esp)
	call eputc
	addl $4, %esp
	subl $4, %esp
	movl $1, %eax
	movl %eax, 0(%esp)
	call exit
	addl $4, %esp
	leave
	ret
parser_parse:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -4(%ebp)
parser_parse_continue:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
_label118:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $256, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label119
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label120
	movl $parser_parse_continue, %eax
	jmp *%eax
_label120:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -16(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl -16(%ebp), %eax
	movl %eax, 8(%esp)
	call top_level_statement
	addl $12, %esp
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	cmpl $0, %eax
	je _label121
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
_label121:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label122
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label123
	movl $parser_parse_error, %eax
	jmp *%eax
_label123:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $0, %eax
	movl %eax, (%ebx)
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_hold
	addl $4, %esp
_label122:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	jmp _label118
_label119:
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_destroy
	addl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	pushl %ebx
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call list_next
	addl $4, %esp
	popl %ebx
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label124
	movl $parser_parse_continue, %eax
	jmp *%eax
_label124:
	movl -4(%ebp), %eax
	leave
	ret
parser_parse_error:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+620, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
top_level_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $281, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label125
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call global_statement
	addl $8, %esp
	leave
	ret
_label125:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $288, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label126
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	call include_statement
	addl $12, %esp
	leave
	ret
_label126:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $289, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label127
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $1, %eax
	movl %eax, 8(%esp)
	call include_statement
	addl $12, %esp
	leave
	ret
_label127:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $258, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label128
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_text
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call strdup
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $304, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label129
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call macro_declaration
	addl $12, %esp
	leave
	ret
_label129:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $58, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label130
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label131
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call function_declaration
	addl $12, %esp
	leave
	ret
_label131:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $91, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label132
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call array_declaration
	addl $12, %esp
	leave
	ret
_label132:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $286, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label133
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $66, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call type_array_declaration
	addl $16, %esp
	leave
	ret
_label133:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $287, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label134
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $67, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call type_array_declaration
	addl $16, %esp
	leave
	ret
_label134:
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call variable_declaration
	addl $16, %esp
	leave
	ret
_label130:
_label128:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+658, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
global_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $258, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label136
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_text
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call strdup
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	jmp _label135
_label136:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label138
global_statement_next:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $258, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label139
	movl $global_statement_invalid, %eax
	jmp *%eax
_label139:
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_text
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call strdup
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label140
	movl $global_statement_next, %eax
	jmp *%eax
_label140:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label141
	movl $global_statement_invalid, %eax
	jmp *%eax
_label141:
	jmp _label137
_label138:
	movl $global_statement_invalid, %eax
	jmp *%eax
_label137:
_label135:
	subl $12, %esp
	movl $62, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
global_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+720, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
include_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $259, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label143
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_text
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call strlitdup
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	jmp _label142
_label143:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label145
include_statement_next:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $259, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label146
	movl $include_statement_invalid, %eax
	jmp *%eax
_label146:
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_text
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call strlitdup
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label147
	movl $include_statement_next, %eax
	jmp *%eax
_label147:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label148
	movl $include_statement_invalid, %eax
	jmp *%eax
_label148:
	jmp _label144
_label145:
	movl $include_statement_invalid, %eax
	jmp *%eax
_label144:
_label142:
	movl $0, %eax
	movl %eax, -8(%ebp)
_label149:
	movl -8(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label150
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call parser_include_add
	addl $12, %esp
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -8(%ebp)
	jmp _label149
_label150:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl $1, %eax
	movl %eax, (%ebx)
	movl $0, %eax
	leave
	ret
include_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+745, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
macro_declaration:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl $63, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	leave
	ret
function_declaration:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
function_declaration_arg_loop:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label151
	movl $function_declaration_arg_end, %eax
	jmp *%eax
_label151:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $321, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label152
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl $function_declaration_arg_end, %eax
	jmp *%eax
_label152:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $260, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label153
	movl $function_declaration_arg_invalid, %eax
	jmp *%eax
_label153:
	movl -4(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_value
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label154
	movl $function_declaration_arg_invalid, %eax
	jmp *%eax
_label154:
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label155
	movl $function_declaration_arg_loop, %eax
	jmp *%eax
_label155:
function_declaration_arg_end:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label156
	movl $function_declaration_arg_invalid, %eax
	jmp *%eax
_label156:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call block_statement
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $20, %esp
	movl $64, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -4(%ebp), %eax
	movl %eax, 12(%esp)
	movl -12(%ebp), %eax
	movl %eax, 16(%esp)
	call tuple5
	addl $20, %esp
	leave
	ret
function_declaration_arg_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+771, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
array_declaration:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -4(%ebp)
array_declaration_loop:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label157
	movl $array_declaration_loop, %eax
	jmp *%eax
_label157:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $93, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label158
	movl $array_declaration_invalid, %eax
	jmp *%eax
_label158:
	subl $16, %esp
	movl $65, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -4(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	leave
	ret
array_declaration_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+817, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
type_array_declaration:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $91, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label159
	movl $type_array_declaration_invalid, %eax
	jmp *%eax
_label159:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $93, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label160
	movl $type_array_declaration_invalid, %eax
	jmp *%eax
_label160:
	subl $16, %esp
	movl 16(%ebp), %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	leave
	ret
type_array_declaration_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+850, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
variable_declaration:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -4(%ebp)
	subl $16, %esp
	movl $68, %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -4(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	leave
	ret
block_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $20, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -16(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $123, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label161
	movl $block_statement_invalid, %eax
	jmp *%eax
_label161:
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -4(%ebp)
block_statement_loop:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -20(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $125, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label162
	movl $block_statement_end, %eax
	jmp *%eax
_label162:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $123, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label164
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call block_statement
	addl $8, %esp
	movl %eax, -12(%ebp)
	jmp _label163
_label164:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl -20(%ebp), %eax
	movl %eax, 8(%esp)
	call statement
	addl $12, %esp
	movl %eax, -12(%ebp)
_label163:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label165
	movl $block_statement_content_invalid, %eax
	jmp *%eax
_label165:
	movl $block_statement_loop, %eax
	jmp *%eax
block_statement_end:
	subl $12, %esp
	movl $61, %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
block_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+888, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
block_statement_content_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -20(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+919, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
statement:
	pushl %ebp
	movl %esp, %ebp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $270, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label167
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call if_statement
	addl $8, %esp
	leave
	ret
	jmp _label166
_label167:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $275, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label168
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call for_statement
	addl $8, %esp
	leave
	ret
	jmp _label166
_label168:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $274, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label169
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call do_while_statement
	addl $8, %esp
	leave
	ret
	jmp _label166
_label169:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $276, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label170
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call while_statement
	addl $8, %esp
	leave
	ret
	jmp _label166
_label170:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $277, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label171
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call allocate_statement
	addl $8, %esp
	leave
	ret
	jmp _label166
_label171:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $278, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label172
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call assembly_statement
	addl $8, %esp
	leave
	ret
	jmp _label166
_label172:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $279, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label173
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call return_statement
	addl $8, %esp
	leave
	ret
	jmp _label166
_label173:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $272, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label174
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $273, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label174
	movl $0, %eax
	jmp _label175
_label174:
	movl $1, %eax
_label175:
	cmpl $0, %eax
	je _label176
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	call loop_jump_statement
	addl $12, %esp
	leave
	ret
	jmp _label166
_label176:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $285, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label177
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call writechar_statement
	addl $8, %esp
	leave
	ret
	jmp _label166
_label177:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $283, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label178
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call label_statement
	addl $8, %esp
	leave
	ret
	jmp _label166
_label178:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $282, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label179
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call goto_statement
	addl $8, %esp
	leave
	ret
	jmp _label166
_label179:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	leave
	ret
_label166:
	leave
	ret
if_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -4(%ebp)
if_statement_parse:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label180
	movl $if_statement_invalid, %eax
	jmp *%eax
_label180:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label181
	movl $if_statement_invalid, %eax
	jmp *%eax
_label181:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call block_statement
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $271, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label182
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl $if_statement_end, %eax
	jmp *%eax
_label182:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $270, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label183
	movl $if_statement_parse, %eax
	jmp *%eax
_label183:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call block_statement
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $271, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label184
	movl $if_statement_else_invalid, %eax
	jmp *%eax
_label184:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
if_statement_end:
	subl $12, %esp
	movl $49, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
if_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+970, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
if_statement_else_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+998, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
for_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $24, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -16(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label185
	movl $for_statement_invalid, %eax
	jmp *%eax
_label185:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label186
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl $for_statement_skip_init, %eax
	jmp *%eax
_label186:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label187
	movl $for_statement_invalid, %eax
	jmp *%eax
_label187:
for_statement_skip_init:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label188
	movl $0, %eax
	movl %eax, -12(%ebp)
	movl $for_statement_skip_cond, %eax
	jmp *%eax
_label188:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label189
	movl $for_statement_invalid, %eax
	jmp *%eax
_label189:
for_statement_skip_cond:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label190
	movl $for_statement_iter_end, %eax
	jmp *%eax
_label190:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
for_statement_iter_loop:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label191
	movl $for_statement_invalid, %eax
	jmp *%eax
_label191:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -24(%ebp)
	subl $8, %esp
	movl -16(%ebp), %eax
	movl %eax, 0(%esp)
	movl -24(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label192
	movl $for_statement_iter_loop, %eax
	jmp *%eax
_label192:
for_statement_iter_end:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label193
	movl $for_statement_invalid, %eax
	jmp *%eax
_label193:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call block_statement
	addl $8, %esp
	movl %eax, -20(%ebp)
	subl $24, %esp
	movl $50, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	movl -16(%ebp), %eax
	movl %eax, 16(%esp)
	movl -20(%ebp), %eax
	movl %eax, 20(%esp)
	call tuple6
	addl $24, %esp
	leave
	ret
for_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1056, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
do_while_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call block_statement
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $276, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label194
	movl $do_while_statement_invalid, %eax
	jmp *%eax
_label194:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label195
	movl $do_while_statement_invalid, %eax
	jmp *%eax
_label195:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label196
	movl $do_while_statement_invalid, %eax
	jmp *%eax
_label196:
	subl $16, %esp
	movl $51, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	leave
	ret
do_while_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1085, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
while_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label197
	movl $while_statement_invalid, %eax
	jmp *%eax
_label197:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label198
	movl $while_statement_invalid, %eax
	jmp *%eax
_label198:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call block_statement
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl $52, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	leave
	ret
while_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1119, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
allocate_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label199
	movl $allocate_statement_invalid, %eax
	jmp *%eax
_label199:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label200
	movl $allocate_statement_invalid, %eax
	jmp *%eax
_label200:
	subl $12, %esp
	movl $53, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
allocate_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1150, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
assembly_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $123, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label201
	movl $assembly_statement_invalid, %eax
	jmp *%eax
_label201:
assembly_statement_loop:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex_asm
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_text
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call strdup
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label202
	movl $assembly_statement_invalid, %eax
	jmp *%eax
_label202:
	movl -12(%ebp), %eax
	cmpl $0, %eax
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label203
	movl $assembly_statement_loop, %eax
	jmp *%eax
_label203:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $125, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label204
	movl $assembly_statement_invalid, %eax
	jmp *%eax
_label204:
	subl $12, %esp
	movl $54, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
assembly_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1184, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
return_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label205
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl $return_statement_end, %eax
	jmp *%eax
_label205:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
return_statement_end:
	subl $12, %esp
	movl $55, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
loop_jump_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $56, %eax
	pushl %ebx
	movl %eax, %ebx
	movl 16(%ebp), %eax
	addl %ebx, %eax
	popl %ebx
	pushl %ebx
	pushl %eax
	movl $272, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call tuple2
	addl $8, %esp
	leave
	ret
writechar_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label206
	movl $writechar_statement_invalid, %eax
	jmp *%eax
_label206:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label207
	movl $writechar_statement_invalid, %eax
	jmp *%eax
_label207:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label208
	movl $writechar_statement_invalid, %eax
	jmp *%eax
_label208:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -16(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label209
	movl $writechar_statement_invalid, %eax
	jmp *%eax
_label209:
	subl $20, %esp
	movl $58, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	movl -16(%ebp), %eax
	movl %eax, 16(%esp)
	call tuple5
	addl $20, %esp
	leave
	ret
writechar_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1218, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
label_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $258, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label210
	movl $label_statement_invalid, %eax
	jmp *%eax
_label210:
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_text
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call strdup
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $12, %esp
	movl $59, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
label_statement_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1246, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
goto_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $12, %esp
	movl $60, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call assignment_expression
	addl $12, %esp
	leave
	ret
assignment_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call ternary_expression
	addl $12, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label211
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $33, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label211:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $309, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label212
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $37, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label212:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $310, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label213
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $38, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label213:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $311, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label214
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $34, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label214:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $312, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label215
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $35, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label215:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $313, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label216
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $36, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label216:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $314, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label217
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $41, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label217:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $315, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label218
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $42, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label218:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $316, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label219
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $43, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label219:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $317, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label220
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $39, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label220:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $318, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label221
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $40, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call assignment_expr
	addl $16, %esp
	leave
	ret
_label221:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl -4(%ebp), %eax
	leave
	ret
assignment_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl -12(%ebp), %eax
	movl %eax, 8(%esp)
	call ternary_expression
	addl $12, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 16(%ebp), %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	leave
	ret
ternary_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call logical_or_expression
	addl $16, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $63, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label222
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call ternary_expr
	addl $16, %esp
	leave
	ret
_label222:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl -4(%ebp), %eax
	leave
	ret
ternary_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -16(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl -16(%ebp), %eax
	movl %eax, 8(%esp)
	call ternary_expression
	addl $12, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $58, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label223
	movl $ternary_expr_error, %eax
	jmp *%eax
_label223:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -16(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl -16(%ebp), %eax
	movl %eax, 8(%esp)
	call ternary_expression
	addl $12, %esp
	movl %eax, -12(%ebp)
	subl $20, %esp
	movl $48, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	movl -12(%ebp), %eax
	movl %eax, 16(%esp)
	call tuple5
	addl $20, %esp
	leave
	ret
ternary_expr_error:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1276, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
logical_or_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label224
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call logical_and_expression
	addl $16, %esp
	movl %eax, 16(%ebp)
_label224:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $308, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label225
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 20(%ebp), %eax
	movl %eax, 8(%esp)
	call logical_or_expr
	addl $12, %esp
	leave
	ret
_label225:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl 16(%ebp), %eax
	leave
	ret
logical_or_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call logical_and_expression
	addl $16, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl $32, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call logical_or_expression
	addl $16, %esp
	leave
	ret
logical_and_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label226
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call equality_expression
	addl $16, %esp
	movl %eax, 16(%ebp)
_label226:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $307, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label227
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 20(%ebp), %eax
	movl %eax, 8(%esp)
	call logical_and_expr
	addl $12, %esp
	leave
	ret
_label227:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl 16(%ebp), %eax
	leave
	ret
logical_and_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call equality_expression
	addl $16, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl $31, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call logical_and_expression
	addl $16, %esp
	leave
	ret
equality_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label228
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call relational_expression
	addl $16, %esp
	movl %eax, 16(%ebp)
_label228:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $300, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label229
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $29, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call equality_expr
	addl $16, %esp
	leave
	ret
_label229:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $301, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label230
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $30, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call equality_expr
	addl $16, %esp
	leave
	ret
_label230:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl 16(%ebp), %eax
	leave
	ret
equality_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call relational_expression
	addl $16, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl 16(%ebp), %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call equality_expression
	addl $16, %esp
	leave
	ret
relational_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label231
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_or_expression
	addl $16, %esp
	movl %eax, 16(%ebp)
_label231:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $60, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label232
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $25, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call relational_expr
	addl $16, %esp
	leave
	ret
_label232:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $62, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label233
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $26, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call relational_expr
	addl $16, %esp
	leave
	ret
_label233:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $302, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label234
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $27, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call relational_expr
	addl $16, %esp
	leave
	ret
_label234:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $303, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label235
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $28, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call relational_expr
	addl $16, %esp
	leave
	ret
_label235:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl 16(%ebp), %eax
	leave
	ret
relational_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_or_expression
	addl $16, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl 16(%ebp), %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call relational_expression
	addl $16, %esp
	leave
	ret
bitwise_or_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label236
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_xor_expression
	addl $16, %esp
	movl %eax, 16(%ebp)
_label236:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $124, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label237
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 20(%ebp), %eax
	movl %eax, 8(%esp)
	call bitwise_or_expr
	addl $12, %esp
	leave
	ret
_label237:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl 16(%ebp), %eax
	leave
	ret
bitwise_or_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_xor_expression
	addl $16, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl $24, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_or_expression
	addl $16, %esp
	leave
	ret
bitwise_xor_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label238
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_and_expression
	addl $16, %esp
	movl %eax, 16(%ebp)
_label238:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $94, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label239
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 20(%ebp), %eax
	movl %eax, 8(%esp)
	call bitwise_xor_expr
	addl $12, %esp
	leave
	ret
_label239:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl 16(%ebp), %eax
	leave
	ret
bitwise_xor_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_and_expression
	addl $16, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl $23, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_xor_expression
	addl $16, %esp
	leave
	ret
bitwise_and_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label240
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_shift_expression
	addl $16, %esp
	movl %eax, 16(%ebp)
_label240:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $38, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label241
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 20(%ebp), %eax
	movl %eax, 8(%esp)
	call bitwise_and_expr
	addl $12, %esp
	leave
	ret
_label241:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl 16(%ebp), %eax
	leave
	ret
bitwise_and_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_shift_expression
	addl $16, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl $22, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_and_expression
	addl $16, %esp
	leave
	ret
bitwise_shift_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label242
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call additive_expression
	addl $16, %esp
	movl %eax, 16(%ebp)
_label242:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $305, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label243
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $20, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_shift_expr
	addl $16, %esp
	leave
	ret
_label243:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $306, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label244
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $21, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_shift_expr
	addl $16, %esp
	leave
	ret
_label244:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl 16(%ebp), %eax
	leave
	ret
bitwise_shift_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call additive_expression
	addl $16, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl 16(%ebp), %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call bitwise_shift_expression
	addl $16, %esp
	leave
	ret
additive_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label245
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call multiplicative_expression
	addl $16, %esp
	movl %eax, 16(%ebp)
_label245:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $43, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label246
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $18, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call additive_expr
	addl $16, %esp
	leave
	ret
_label246:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $45, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label247
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $19, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call additive_expr
	addl $16, %esp
	leave
	ret
_label247:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl 16(%ebp), %eax
	leave
	ret
additive_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call multiplicative_expression
	addl $16, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl 16(%ebp), %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call additive_expression
	addl $16, %esp
	leave
	ret
multiplicative_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label248
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl 20(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expression
	addl $12, %esp
	movl %eax, 16(%ebp)
_label248:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $42, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label249
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $15, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call multiplicative_expr
	addl $16, %esp
	leave
	ret
_label249:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $47, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label250
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $16, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call multiplicative_expr
	addl $16, %esp
	leave
	ret
_label250:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $37, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label251
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $17, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call multiplicative_expr
	addl $16, %esp
	leave
	ret
_label251:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl 16(%ebp), %eax
	leave
	ret
multiplicative_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl -12(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expression
	addl $12, %esp
	movl %eax, -8(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl 16(%ebp), %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call multiplicative_expression
	addl $16, %esp
	leave
	ret
prefix_expression:
	pushl %ebp
	movl %esp, %ebp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $43, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label253
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $9, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expr
	addl $12, %esp
	leave
	ret
	jmp _label252
_label253:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $45, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label254
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expr
	addl $12, %esp
	leave
	ret
	jmp _label252
_label254:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $33, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label255
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $11, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expr
	addl $12, %esp
	leave
	ret
	jmp _label252
_label255:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $126, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label256
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $12, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expr
	addl $12, %esp
	leave
	ret
	jmp _label252
_label256:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $42, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label257
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $13, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expr
	addl $12, %esp
	leave
	ret
	jmp _label252
_label257:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $38, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label258
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $14, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expr
	addl $12, %esp
	leave
	ret
	jmp _label252
_label258:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $320, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label259
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $44, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expr
	addl $12, %esp
	leave
	ret
	jmp _label252
_label259:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $319, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label260
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $45, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expr
	addl $12, %esp
	leave
	ret
	jmp _label252
_label260:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call simple_expression
	addl $12, %esp
	leave
	ret
_label252:
	leave
	ret
prefix_expr:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	call prefix_expression
	addl $12, %esp
	movl %eax, -12(%ebp)
	subl $12, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl -12(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
simple_expression:
	pushl %ebp
	movl %esp, %ebp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $258, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label261
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call simple_identifier_expression
	addl $8, %esp
	leave
	ret
_label261:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $260, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label262
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call simple_argvar_expression
	addl $12, %esp
	leave
	ret
_label262:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $261, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label263
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call simple_argvar_expression
	addl $12, %esp
	leave
	ret
_label263:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $280, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label264
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call simple_syscall_expression
	addl $8, %esp
	leave
	ret
_label264:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $284, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label265
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call simple_readchar_expression
	addl $8, %esp
	leave
	ret
_label265:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label266
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call simple_parantheses_expression
	addl $8, %esp
	leave
	ret
_label266:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call constant_expression
	addl $12, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call simple_postfix_expression
	addl $8, %esp
	leave
	ret
simple_identifier_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_text
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call strdup
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $12, %esp
	movl $2, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call simple_postfix_expression
	addl $8, %esp
	leave
	ret
simple_argvar_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $4, %eax
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	cmpl $0, %eax
	je _label267
	movl $3, %eax
	movl %eax, -4(%ebp)
_label267:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $12, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_value
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call simple_postfix_expression
	addl $8, %esp
	leave
	ret
simple_syscall_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label268
	movl $simple_syscall_expression_invalid, %eax
	jmp *%eax
_label268:
simple_syscall_expression_loop:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label269
	movl $simple_syscall_expression_loop, %eax
	jmp *%eax
_label269:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label270
	movl $simple_syscall_expression_invalid, %eax
	jmp *%eax
_label270:
	subl $4, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	movl %eax, %edx
	movl $7, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label271
	movl $simple_syscall_expression_too_many, %eax
	jmp *%eax
_label271:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $12, %esp
	movl $5, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call simple_postfix_expression
	addl $8, %esp
	leave
	ret
simple_syscall_expression_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1312, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
simple_syscall_expression_too_many:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1339, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
simple_readchar_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label272
	movl $simple_readchar_expression_invalid, %eax
	jmp *%eax
_label272:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label273
	movl $simple_readchar_expression_invalid, %eax
	jmp *%eax
_label273:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label274
	movl $simple_readchar_expression_invalid, %eax
	jmp *%eax
_label274:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl $6, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	movl -12(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call simple_postfix_expression
	addl $8, %esp
	leave
	ret
simple_readchar_expression_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1380, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
simple_parantheses_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label275
	movl $simple_parantheses_expression_invalid, %eax
	jmp *%eax
_label275:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call simple_postfix_expression
	addl $8, %esp
	leave
	ret
simple_parantheses_expression_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1408, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
simple_postfix_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_token_location
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label277
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	call simple_address_call_expression
	addl $12, %esp
	leave
	ret
	jmp _label276
_label277:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $91, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label278
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	call simple_address_index_expression
	addl $12, %esp
	leave
	ret
	jmp _label276
_label278:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $320, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label279
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $12, %esp
	movl $46, %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call simple_postfix_expression
	addl $8, %esp
	leave
	ret
	jmp _label276
_label279:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $319, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label276
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $12, %esp
	movl $47, %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call simple_postfix_expression
	addl $8, %esp
	leave
	ret
_label276:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	subl $4, %esp
	movl -8(%ebp), %eax
	movl %eax, 0(%esp)
	call free
	addl $4, %esp
	movl 12(%ebp), %eax
	leave
	ret
simple_address_call_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $8, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector
	addl $8, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
simple_address_call_expression_loop:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label280
	movl $simple_address_call_expression_end, %eax
	jmp *%eax
_label280:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label281
	movl $simple_address_call_expression_loop, %eax
	jmp *%eax
_label281:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label282
	movl $simple_address_call_expression_invalid, %eax
	jmp *%eax
_label282:
simple_address_call_expression_end:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $12, %esp
	movl $7, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call simple_postfix_expression
	addl $8, %esp
	leave
	ret
simple_address_call_expression_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1445, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
simple_address_index_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $93, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label283
	movl $simple_address_index_expression_invalid, %eax
	jmp *%eax
_label283:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $16, %esp
	movl $8, %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call tuple4
	addl $16, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call simple_postfix_expression
	addl $8, %esp
	leave
	ret
simple_address_index_expression_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1475, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
constant_expression:
	pushl %ebp
	movl %esp, %ebp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $257, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label284
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call constant_integer_expression
	addl $8, %esp
	leave
	ret
_label284:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $259, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label285
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call constant_string_expression
	addl $8, %esp
	leave
	ret
_label285:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1506, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
	leave
	ret
constant_integer_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_value
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
constant_string_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call lexer_token_text
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $12, %esp
	movl $1, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_buffer
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call string_buffer_push
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
string_buffer:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl $16384, %eax
	movl %eax, 0(%esp)
	call calloc
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
	leave
	ret
string_buffer_offset:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
string_buffer_length:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
string_buffer_find:
	pushl %ebp
	movl %esp, %ebp
	subl $20, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call string_buffer_length
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label286
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -12(%ebp)
	movl $0, %eax
	movl %eax, -16(%ebp)
_label287:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl -8(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label288
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl -12(%ebp), %eax
	addl %ebx, %eax
	movl %eax, -20(%ebp)
	subl $8, %esp
	movl -20(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call strcmp
	addl $8, %esp
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label289
	movl -16(%ebp), %eax
	leave
	ret
_label289:
	movl -12(%ebp), %eax
	movl %eax, %ebx
	pushl %ebx
	subl $4, %esp
	movl -20(%ebp), %eax
	movl %eax, 0(%esp)
	call strlen
	addl $4, %esp
	popl %ebx
	addl %ebx, %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -12(%ebp)
	movl -16(%ebp), %eax
	movl %eax, %ebx
	pushl %ebx
	subl $4, %esp
	movl -20(%ebp), %eax
	movl %eax, 0(%esp)
	call stresclen
	addl $4, %esp
	popl %ebx
	addl %ebx, %eax
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	movl %eax, -16(%ebp)
	jmp _label287
_label288:
_label286:
	movl $1, %eax
	negl %eax
	leave
	ret
string_buffer_push:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call string_buffer_find
	addl $8, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	negl %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label290
	movl -4(%ebp), %eax
	leave
	ret
_label290:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call string_buffer_offset
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call string_buffer_length
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	call strlen
	addl $4, %esp
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl -12(%ebp), %eax
	addl %ebx, %eax
	movl %eax, %edx
	movl $16384, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label291
	subl $4, %esp
	movl $strbuf+1559, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl $1, %eax
	movl %eax, 0(%esp)
	call exit
	addl $4, %esp
_label291:
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl -8(%ebp), %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call strcpy
	addl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	pushl %ebx
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	call stresclen
	addl $4, %esp
	popl %ebx
	addl %ebx, %eax
	popl %ebx
	pushl %ebx
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl -8(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	movl -12(%ebp), %eax
	addl %ebx, %eax
	popl %ebx
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
string_buffer_export:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call string_buffer_length
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label292
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1590, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl $0, %eax
	movl %eax, -12(%ebp)
_label293:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl -8(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label294
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1599, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	movl -12(%ebp), %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	movl -12(%ebp), %eax
	movl %eax, %ebx
	pushl %ebx
	subl $4, %esp
	movl -4(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	movl -12(%ebp), %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, 0(%esp)
	call strlen
	addl $4, %esp
	popl %ebx
	addl %ebx, %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -12(%ebp)
	jmp _label293
_label294:
_label292:
	leave
	ret
.data
registers:.long strbuf+1608,strbuf+1613,strbuf+1618,strbuf+1623,strbuf+1628,strbuf+1633,strbuf+1638
.text
compiler:
	pushl %ebp
	movl %esp, %ebp
	subl $24, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl $0, %eax
	movl %eax, 12(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $24, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	movl $0, %eax
	movl %eax, 12(%esp)
	movl $0, %eax
	movl %eax, 16(%esp)
	movl $0, %eax
	movl %eax, 20(%esp)
	call tuple6
	addl $24, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 16(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl $0, %eax
	movl %eax, 0(%esp)
	call list
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 20(%esp)
	call tuple6
	addl $24, %esp
	leave
	ret
compiler_output_chan:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
compiler_label_id:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	leave
	ret
compiler_set_segment:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label295
	leave
	ret
_label295:
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 12(%ebp), %eax
	movl %eax, (%ebx)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label296
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1643, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label296:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label297
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1650, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label297:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label298
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1657, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label298:
	leave
	ret
compiler_allocate_register:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label299
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1675, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	leal registers(,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label299:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	leave
	ret
compiler_free_register:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl -8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl 12(%ebp), %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	popl %edx
	setne %al
	movzbl %al, %eax
	movl %eax, 0(%esp)
	movl $strbuf+1683, %eax
	movl %eax, 4(%esp)
	call assert
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label300
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1716, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	leal registers(,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label300:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl 12(%ebp), %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %ebx
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	leave
	ret
compiler_new_label:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_label_id
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, (%ebx)
	movl -4(%ebp), %eax
	leave
	ret
compiler_loop:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call list_value
	addl $4, %esp
	leave
	ret
compiler_push_loop:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call tuple2
	addl $8, %esp
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	pushl %ebx
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call list_insert
	addl $8, %esp
	popl %ebx
	movl %eax, (%ebx)
	leave
	ret
compiler_pop_loop:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call list_value
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	popl %edx
	setne %al
	movzbl %al, %eax
	movl %eax, 0(%esp)
	movl $strbuf+1723, %eax
	movl %eax, 4(%esp)
	call assert
	addl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	pushl %ebx
	subl $4, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call list_pop
	addl $4, %esp
	popl %ebx
	movl %eax, (%ebx)
	leave
	ret
fputlabel:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1758, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	leave
	ret
fputlabeldef:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1765, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compiler_error:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $strbuf+1768, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $8, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl stderr, %eax
	movl %eax, 4(%esp)
	call fputloc
	addl $8, %esp
	subl $4, %esp
	movl $strbuf+294, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl 16(%ebp), %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl $10, %eax
	movl %eax, 0(%esp)
	call eputc
	addl $4, %esp
	leave
	ret
compiler_compile:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compiler_use_macros
	addl $8, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
_label301:
	movl -4(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label302
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call compile_top_level_statement
	addl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label301
_label302:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $2, %eax
	movl %eax, 4(%esp)
	call compiler_set_segment
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl 8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call string_buffer_export
	addl $8, %esp
	leave
	ret
compiler_use_macros:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
_label303:
	movl -4(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label304
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $63, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label305
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -12(%ebp)
_label306:
	movl -12(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label307
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	movl -8(%ebp), %eax
	movl %eax, 8(%esp)
	call compiler_use_macro
	addl $12, %esp
	movl -12(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -12(%ebp)
	jmp _label306
_label307:
_label305:
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label303
_label304:
	leave
	ret
compiler_use_macro:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $2, %eax
	movl %eax, -8(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label308
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label308:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $7, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label309
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label309:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label310
	movl $2, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label310:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $8, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label311
	movl $2, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label311:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $9, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label313
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $14, %eax
	cmpl %eax, %edx
	setle %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label313
	movl $1, %eax
	jmp _label314
_label313:
	movl $0, %eax
_label314:
	cmpl $0, %eax
	je _label312
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label312:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $15, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label316
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	setle %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label316
	movl $1, %eax
	jmp _label317
_label316:
	movl $0, %eax
_label317:
	cmpl $0, %eax
	je _label315
	movl $2, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label315:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $48, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label318
	movl $3, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label318:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $49, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label319
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label319:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label320
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label320:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $55, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label321
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label321:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $65, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label322
	movl $3, %eax
	movl %eax, -8(%ebp)
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label322:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $53, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label323
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label323:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $50, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label324
	movl $4, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label324:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $51, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label325
	movl $2, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label325:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $52, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label326
	movl $2, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label326:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $58, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label327
	movl $3, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label327:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $60, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label328
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label328:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $63, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label329
	movl $3, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label329:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $64, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label330
	movl $4, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label330:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $66, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label331
	movl $3, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label331:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $67, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label332
	movl $3, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label332:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $68, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label333
	movl $3, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label333:
compiler_use_macro_exit:
	leave
	ret
compiler_use_macro_tuple:
	movl $0, %eax
	movl %eax, -4(%ebp)
_label334:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl -12(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label335
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	addl %ebx, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label337
	subl $8, %esp
	movl -16(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call strcmp
	addl $8, %esp
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label338
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	addl %ebx, %eax
	leal (%edx,%eax,4), %eax
	movl %eax, %ebx
	movl 16(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, (%ebx)
_label338:
	jmp _label336
_label337:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call compiler_use_macro
	addl $12, %esp
_label336:
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label334
_label335:
	movl $compiler_use_macro_exit, %eax
	jmp *%eax
compiler_use_macro_vector:
	movl $0, %eax
	movl %eax, -4(%ebp)
_label339:
	movl -4(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl -8(%ebp), %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label340
	subl $8, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl -8(%ebp), %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label342
	subl $8, %esp
	movl -16(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call strcmp
	addl $8, %esp
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label343
	subl $12, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl -8(%ebp), %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 8(%esp)
	call vector_set
	addl $12, %esp
_label343:
	jmp _label341
_label342:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call compiler_use_macro
	addl $12, %esp
_label341:
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label339
_label340:
	movl $compiler_use_macro_exit, %eax
	jmp *%eax
	leave
	ret
compile_top_level_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $62, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label345
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_global_statement
	addl $8, %esp
	jmp _label344
_label345:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $64, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label346
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_function_declaration
	addl $8, %esp
	jmp _label344
_label346:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $65, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label347
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_array_declaration
	addl $8, %esp
	jmp _label344
_label347:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $66, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label348
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $1, %eax
	movl %eax, 8(%esp)
	call compile_type_array_declaration
	addl $12, %esp
	jmp _label344
_label348:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $67, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label349
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $4, %eax
	movl %eax, 8(%esp)
	call compile_type_array_declaration
	addl $12, %esp
	jmp _label344
_label349:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $68, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label344
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_variable_declaration
	addl $8, %esp
_label344:
	leave
	ret
compile_global_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1776, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl $0, %eax
	movl %eax, -8(%ebp)
_label350:
	movl -8(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label351
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label352
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $44, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label352:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -8(%ebp)
	jmp _label350
_label351:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
compile_function_declaration:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	call compiler_set_segment
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1765, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1785, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1798, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_block_statement
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_function_declaration_return
	addl $8, %esp
	leave
	ret
compile_function_declaration_return:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label353
	movl $compile_function_declaration_return_print, %eax
	jmp *%eax
_label353:
	subl $4, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_pop
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $55, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label354
	leave
	ret
_label354:
compile_function_declaration_return_print:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1816, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_array_declaration:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_set_segment
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1829, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl $0, %eax
	movl %eax, -8(%ebp)
_label355:
	movl -8(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label356
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label357
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $44, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label357:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call compile_simple_value
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -8(%ebp)
	jmp _label355
_label356:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
compile_type_array_declaration:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label358
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1837, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label358:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_set_segment
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1881, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $44, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	pushl %ebx
	movl %eax, %ebx
	movl 16(%ebp), %eax
	imull %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
compile_variable_declaration:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_set_segment
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1829, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_simple_value
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
compile_block_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
_label359:
	movl -4(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label360
	subl $8, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -16(%ebp)
	movl -8(%ebp), %eax
	cmpl $0, %eax
	je _label361
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label363
	movl $0, %eax
	movl %eax, -8(%ebp)
	jmp _label362
_label363:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1888, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label362:
_label361:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call compile_statement
	addl $8, %esp
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $55, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label365
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $60, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label365
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $56, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label365
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $57, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label365
	movl $0, %eax
	jmp _label366
_label365:
	movl $1, %eax
_label366:
	cmpl $0, %eax
	je _label364
	movl $1, %eax
	movl %eax, -8(%ebp)
_label364:
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label359
_label360:
	leave
	ret
compile_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $49, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label368
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_if_statement
	addl $8, %esp
	jmp _label367
_label368:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $50, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label369
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_for_statement
	addl $8, %esp
	jmp _label367
_label369:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $51, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label370
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $1, %eax
	movl %eax, 8(%esp)
	call compile_while_statement
	addl $12, %esp
	jmp _label367
_label370:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $52, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label371
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	call compile_while_statement
	addl $12, %esp
	jmp _label367
_label371:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $53, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label372
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_allocate_statement
	addl $8, %esp
	jmp _label367
_label372:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $54, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label373
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_assembly_statement
	addl $8, %esp
	jmp _label367
_label373:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $55, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label374
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_return_statement
	addl $8, %esp
	jmp _label367
_label374:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $56, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label375
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $57, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label375
	movl $0, %eax
	jmp _label376
_label375:
	movl $1, %eax
_label376:
	cmpl $0, %eax
	je _label377
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_loop_jump_statement
	addl $8, %esp
	jmp _label367
_label377:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $58, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label378
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_writechar_statement
	addl $8, %esp
	jmp _label367
_label378:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label379
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_label_statement
	addl $8, %esp
	jmp _label367
_label379:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $60, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label380
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_goto_statement
	addl $8, %esp
	jmp _label367
_label380:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label381
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_block_statement
	addl $8, %esp
	jmp _label367
_label381:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
_label367:
	leave
	ret
compile_if_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $20, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl $0, %eax
	movl %eax, -16(%ebp)
_label382:
	movl -16(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label383
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label384
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1906, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
_label384:
	subl $8, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label385
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -20(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	movl -16(%ebp), %eax
	movl %eax, %ebx
	movl $2, %eax
	addl %ebx, %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label386
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	jmp _label387
_label386:
	movl -8(%ebp), %eax
_label387:
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1912, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1928, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	movl -16(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -16(%ebp)
	subl $8, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	movl %eax, -20(%ebp)
_label385:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -20(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_block_statement
	addl $8, %esp
	movl -16(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -16(%ebp)
	jmp _label382
_label383:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
	leave
	ret
compile_for_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $20, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -16(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	cmpl $0, %eax
	je _label388
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
_label388:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	cmpl $0, %eax
	je _label389
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1912, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1928, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label389:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -16(%ebp), %eax
	movl %eax, 8(%esp)
	call compiler_push_loop
	addl $12, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $5, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_block_statement
	addl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_pop_loop
	addl $4, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
	movl $0, %eax
	movl %eax, -20(%ebp)
_label390:
	movl -20(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label391
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -20(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	movl -20(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -20(%ebp)
	jmp _label390
_label391:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1906, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
	leave
	ret
compile_while_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
	movl 16(%ebp), %eax
	cmpl $0, %eax
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label392
	subl $20, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	movl -12(%ebp), %eax
	movl %eax, 16(%esp)
	call compile_while_condition
	addl $20, %esp
_label392:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl -12(%ebp), %eax
	movl %eax, 8(%esp)
	call compiler_push_loop
	addl $12, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_block_statement
	addl $8, %esp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl -12(%ebp), %eax
	movl %eax, 8(%esp)
	call compiler_pop_loop
	addl $12, %esp
	movl 16(%ebp), %eax
	cmpl $0, %eax
	je _label394
	subl $20, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	movl -12(%ebp), %eax
	movl %eax, 16(%esp)
	call compile_while_condition
	addl $20, %esp
	jmp _label393
_label394:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1906, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label393:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
	leave
	ret
compile_while_condition:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1912, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	cmpl $0, %eax
	je _label395
	movl $strbuf+1933, %eax
	jmp _label396
_label395:
	movl $strbuf+1928, %eax
_label396:
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	cmpl $0, %eax
	je _label397
	movl 20(%ebp), %eax
	jmp _label398
_label397:
	movl 24(%ebp), %eax
_label398:
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
compile_allocate_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label399
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1939, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label399:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %ebx
	movl $4, %eax
	imull %ebx, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setle %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label400
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1983, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label400:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2014, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2022, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_assembly_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
_label401:
	movl -8(%ebp), %eax
	movl %eax, %edx
	pushl %edx
	subl $4, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	popl %edx
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label403
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $9, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label402:
	movl -8(%ebp), %eax
	leal 1(%eax), %edx
	movl %edx, -8(%ebp)
	jmp _label401
_label403:
	leave
	ret
compile_return_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label404
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_pop
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
_label404:
	subl $8, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	movl $strbuf+1816, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_loop_jump_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_loop
	addl $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	cmpl $0, %eax
	je _label406
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $56, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label407
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	jmp _label408
_label407:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
_label408:
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1906, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	jmp _label405
_label406:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+2030, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label405:
	leave
	ret
compile_writechar_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2074, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2092, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2110, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	leave
	ret
compile_label_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1765, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_goto_statement:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	movl $strbuf+2129, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label410
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_integer_expression
	addl $8, %esp
	jmp _label409
_label410:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label411
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_string_expression
	addl $8, %esp
	jmp _label409
_label411:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $7, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label412
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_address_call_expression
	addl $8, %esp
	jmp _label409
_label412:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $8, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label413
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_address_index_expression
	addl $8, %esp
	jmp _label409
_label413:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label414
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_simple_identifier_expression
	addl $8, %esp
	jmp _label409
_label414:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label415
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_simple_argument_expression
	addl $8, %esp
	jmp _label409
_label415:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label416
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_simple_variable_expression
	addl $8, %esp
	jmp _label409
_label416:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label417
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_simple_syscall_expression
	addl $8, %esp
	jmp _label409
_label417:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label418
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_simple_readchar_expression
	addl $8, %esp
	jmp _label409
_label418:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $9, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label419
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_plus_expression
	addl $8, %esp
	jmp _label409
_label419:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $10, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label420
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_minus_expression
	addl $8, %esp
	jmp _label409
_label420:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $11, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label421
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_logical_not_expression
	addl $8, %esp
	jmp _label409
_label421:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $12, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label422
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_not_expression
	addl $8, %esp
	jmp _label409
_label422:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $13, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label423
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_deref_expression
	addl $8, %esp
	jmp _label409
_label423:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $14, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label424
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_addrof_expression
	addl $8, %esp
	jmp _label409
_label424:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $15, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label425
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $24, %eax
	cmpl %eax, %edx
	setle %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label425
	movl $1, %eax
	jmp _label426
_label425:
	movl $0, %eax
_label426:
	cmpl $0, %eax
	je _label427
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 8(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 12(%esp)
	call compile_bitwise_arithmetic_expression
	addl $16, %esp
	jmp _label409
_label427:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $25, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label428
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
	jmp _label409
_label428:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $26, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label429
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
	jmp _label409
_label429:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $27, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label430
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
	jmp _label409
_label430:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $28, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label431
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
	jmp _label409
_label431:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $29, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label432
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
	jmp _label409
_label432:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $30, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label433
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
	jmp _label409
_label433:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $31, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label434
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	call compile_logical_expression
	addl $12, %esp
	jmp _label409
_label434:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $32, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label435
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $1, %eax
	movl %eax, 8(%esp)
	call compile_logical_expression
	addl $12, %esp
	jmp _label409
_label435:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $48, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label436
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_ternary_expression
	addl $8, %esp
	jmp _label409
_label436:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $33, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label437
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $47, %eax
	cmpl %eax, %edx
	setle %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label437
	movl $1, %eax
	jmp _label438
_label437:
	movl $0, %eax
_label438:
	cmpl $0, %eax
	je _label439
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_assignment_expression
	addl $8, %esp
	jmp _label409
_label439:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+2141, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label409:
	leave
	ret
compile_address_call_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $20, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl -8(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	movl %eax, -20(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	movl -20(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label440
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -20(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2176, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label440:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $2, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $5, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label441
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2014, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	pushl %ebx
	movl %eax, %ebx
	movl -12(%ebp), %eax
	pushl %ebx
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	imull %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2022, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label441:
	movl $1, %eax
	movl %eax, -16(%ebp)
_label442:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl -12(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label443
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2194, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	pushl %ebx
	movl %eax, %ebx
	movl -16(%ebp), %eax
	pushl %ebx
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	imull %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2207, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl -16(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -16(%ebp)
	jmp _label442
_label443:
	movl -20(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label445
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2215, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -20(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	jmp _label444
_label445:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2222, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label444:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label446
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2235, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	pushl %ebx
	movl %eax, %ebx
	movl -12(%ebp), %eax
	pushl %ebx
	pushl %eax
	movl $1, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	imull %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2022, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label446:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $5, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $2, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	leave
	ret
compile_address_index_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_address_index_address
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2243, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_address_index_address:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $8, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label448
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_address_index_address
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2263, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label447
_label448:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label449
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2074, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label449:
_label447:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2283, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label451
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2290, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label450
_label451:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2307, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label450:
	leave
	ret
compile_simple_identifier_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2328, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2335, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_simple_argument_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2328, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputarg
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2335, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
fputarg:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	pushl %ebx
	movl %eax, %ebx
	movl 12(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $2, %eax
	addl %ebx, %eax
	popl %ebx
	imull %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2343, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_simple_variable_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2328, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputvar
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2335, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
fputvar:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $45, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	pushl %ebx
	movl %eax, %ebx
	movl 12(%ebp), %eax
	pushl %ebx
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	popl %ebx
	imull %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2343, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_simple_syscall_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl -8(%ebp), %eax
	movl %eax, 0(%esp)
	call vector_size
	addl $4, %esp
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label452
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
_label452:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label453
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $2, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
_label453:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label454
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
_label454:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label455
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
_label455:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label456
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $5, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
_label456:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label457
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1785, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label457:
	movl $0, %eax
	movl %eax, -16(%ebp)
_label458:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl -12(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label459
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label460
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2194, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	leal registers(,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label460:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	movl %eax, %ebx
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	imull %ebx, %eax
	cmpl $0, %eax
	je _label461
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2350, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label461:
	movl -16(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -16(%ebp)
	jmp _label458
_label459:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label462
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2363, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label462:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2375, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label463
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2387, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label463:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label464
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $5, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label464:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label465
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label465:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label466
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label466:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label467
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $2, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label467:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label468
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label468:
	leave
	ret
compile_simple_readchar_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2074, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2092, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2399, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	leave
	ret
compile_prefix_plus_expression:
	pushl %ebp
	movl %esp, %ebp
	leave
	ret
compile_prefix_minus_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2421, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_prefix_logical_not_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1912, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2433, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2444, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_prefix_not_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2463, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_prefix_deref_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2243, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_prefix_addrof_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label469
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2475, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2335, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
_label469:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label470
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2283, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputarg
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2335, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
_label470:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label471
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2283, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputvar
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2335, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
_label471:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+2483, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
	leave
	ret
compile_bitwise_arithmetic_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $19, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label473
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2350, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label472
_label473:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $16, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label474
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $17, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label474
	movl $0, %eax
	jmp _label475
_label474:
	movl $1, %eax
_label475:
	cmpl $0, %eax
	je _label476
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2350, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label472
_label476:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2176, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label472:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $20, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label478
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $21, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label478
	movl $0, %eax
	jmp _label479
_label478:
	movl $1, %eax
_label479:
	cmpl $0, %eax
	je _label480
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $2, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2528, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2546, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label477
_label480:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $19, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label481
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2176, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2363, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label477
_label481:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $16, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label482
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $17, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label482
	movl $0, %eax
	jmp _label483
_label482:
	movl $1, %eax
_label483:
	cmpl $0, %eax
	je _label477
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2176, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2363, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2564, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label477:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $9, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $15, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label485
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2571, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label484
_label485:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $16, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label486
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2588, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label484
_label486:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $17, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label487
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2599, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label484
_label487:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $18, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label488
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2627, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label484
_label488:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $19, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label489
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2643, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label484
_label489:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $20, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label490
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2659, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label484
_label490:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $21, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label491
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2674, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label484
_label491:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $22, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label492
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2689, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label484
_label492:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $23, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label493
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2705, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label484
_label493:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $24, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label484
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2721, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label484:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $20, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label495
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $21, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label495
	movl $0, %eax
	jmp _label496
_label495:
	movl $1, %eax
_label496:
	cmpl $0, %eax
	je _label497
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $2, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	jmp _label494
_label497:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $16, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label498
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $17, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label498
	movl $0, %eax
	jmp _label499
_label498:
	movl $1, %eax
_label499:
	cmpl $0, %eax
	je _label494
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label494:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	leave
	ret
compile_comparison_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2074, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2736, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $9, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $29, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label500
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2754, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label500:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $30, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label501
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2759, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label501:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $25, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label502
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2765, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label502:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $26, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label503
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2770, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label503:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $27, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label504
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2775, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label504:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $28, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label505
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2781, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label505:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2787, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_logical_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call compile_logical_expression_operand
	addl $16, %esp
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	movl -8(%ebp), %eax
	movl %eax, 12(%esp)
	call compile_logical_expression_operand
	addl $16, %esp
	movl 16(%ebp), %eax
	cmpl $0, %eax
	je _label507
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2811, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label506
_label507:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2827, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label506:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1906, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
	movl 16(%ebp), %eax
	cmpl $0, %eax
	je _label509
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2827, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label508
_label509:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2811, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label508:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
	leave
	ret
compile_logical_expression_operand:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	pushl %eax
	movl $31, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	movl %eax, %edx
	movl 16(%ebp), %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label510
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call compile_logical_expression_operand
	addl $16, %esp
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call compile_logical_expression_operand
	addl $16, %esp
	leave
	ret
_label510:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1912, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl 16(%ebp), %eax
	cmpl $0, %eax
	je _label512
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1933, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label511
_label512:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1928, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label511:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 20(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
compile_ternary_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -12(%ebp)
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1912, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1928, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1906, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabel
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $4, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call fputlabeldef
	addl $8, %esp
	leave
	ret
compile_assignment_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $8, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label513
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_address_index_address
	addl $8, %esp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2176, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label513:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $33, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label515
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	jmp _label514
_label515:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label516
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $47, %eax
	cmpl %eax, %edx
	setle %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label516
	movl $1, %eax
	jmp _label517
_label516:
	movl $0, %eax
_label517:
	cmpl $0, %eax
	je _label518
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label520
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2843, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label519
_label520:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $45, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label521
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2859, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label519
_label521:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2283, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $46, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label522
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $45, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label522:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2875, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label519:
	jmp _label514
_label518:
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	pushl %ebx
	pushl %eax
	movl $34, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	pushl %ebx
	movl %eax, %ebx
	movl $15, %eax
	addl %ebx, %eax
	popl %ebx
	movl %eax, 4(%esp)
	movl -12(%ebp), %eax
	movl %eax, 8(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $3, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 12(%esp)
	call compile_bitwise_arithmetic_expression
	addl $16, %esp
_label514:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2328, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $46, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label524
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $47, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label524
	movl $0, %eax
	jmp _label525
_label524:
	movl $1, %eax
_label525:
	cmpl $0, %eax
	je _label526
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1623, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label523
_label526:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1608, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label523:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2890, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label528
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label527
_label528:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label529
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputarg
	addl $8, %esp
	jmp _label527
_label529:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label530
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputvar
	addl $8, %esp
	jmp _label527
_label530:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $8, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label531
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2893, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label527
_label531:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+2900, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label527:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $46, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label533
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $47, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	jne _label533
	movl $0, %eax
	jmp _label534
_label533:
	movl $1, %eax
_label534:
	cmpl $0, %eax
	je _label532
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label532:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $8, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label535
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label535:
	leave
	ret
compile_integer_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2475, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2335, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_string_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2938, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2335, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_simple_value:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_output_chan
	addl $4, %esp
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label536
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	leave
	ret
_label536:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label537
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2953, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputd
	addl $8, %esp
	leave
	ret
_label537:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label538
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
_label538:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+2961, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
	leave
	ret
usage:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $strbuf+3001, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl $strbuf+3009, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	leave
	ret
main:
	pushl %ebp
	movl %esp, %ebp
	subl $28, %esp
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label539
	subl $4, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call usage
	addl $4, %esp
	movl $1, %eax
	leave
	ret
_label539:
	subl $4, %esp
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	call input_chan_file
	addl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	movl $strbuf+3030, %eax
	movl %eax, 0(%esp)
	call output_chan_file
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $1, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 4(%esp)
	call lexer
	addl $8, %esp
	movl %eax, -12(%ebp)
	call string_buffer
	movl %eax, -16(%ebp)
	subl $8, %esp
	movl -12(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	call parser
	addl $8, %esp
	movl %eax, -20(%ebp)
	subl $4, %esp
	movl -20(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_parse
	addl $4, %esp
	movl %eax, -24(%ebp)
	subl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	call compiler
	addl $8, %esp
	movl %eax, -28(%ebp)
	subl $8, %esp
	movl -28(%ebp), %eax
	movl %eax, 0(%esp)
	movl -24(%ebp), %eax
	movl %eax, 4(%esp)
	call compiler_compile
	addl $8, %esp
	movl $0, %eax
	leave
	ret
.global _start
_start:
	pushl %ebp
	movl %esp, %ebp
	call initialize_io
	subl $4, %esp
	pushl %ebx
	pushl %ecx
	pushl %edx
	pushl %esi
	pushl %edi
	subl $8, %esp
	leal 8(%ebp), %eax
	pushl %ebx
	pushl %eax
	movl $4, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	popl %ebx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	leal 8(%ebp), %eax
	movl %eax, 4(%esp)
	call main
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 0(%esp)
	call exit
	addl $4, %esp
	leave
	ret
.section .rodata
strbuf:
.string "0123456789abcdefghijklmnopqrstuvwxyz"
.string "Couldn't open file input channel"
.string "Couldn't open file output channel"
.string "ASSERT: "
.string "assertion failed"
.string "if"
.string "else"
.string "break"
.string "continue"
.string "do"
.string "for"
.string "while"
.string "allocate"
.string "asm"
.string "return"
.string "syscall"
.string "global"
.string "goto"
.string "label"
.string "readchar"
.string "writechar"
.string "char"
.string "int"
.string "include"
.string "include_once"
.string "tried to hold two or more tokens"
.string ": "
.string "Invalid character"
.string "Unexpected second 0 char"
.string "Unexpected decimal digit (expected octal)"
.string "Unexpected hexadecimal digit (expected octal)"
.string "Unfinished hexadecimal number"
.string "Unexpected hexadecimal digit (expected decimal)"
.string "Unterminated character literal"
.string "Unterminated string literal"
.string "Unexpected assembly block close"
.string "Unexpected end of file"
.string "Statement is not ended with semicolon"
.string "Syntax error - none of available top level statements matched"
.string "Invalid global statement"
.string "Invalid include statement"
.string "Invalid function arguments declaration syntax"
.string "Invalid array declaration syntax"
.string "Invalid char array declaration syntax"
.string "Invalid block statement syntax"
.string "Statement inside block is not ended with semicolon"
.string "Invalid if statement syntax"
.string "Put else branches with condition before last else branch."
.string "Invalid for statement syntax"
.string "Invalid do-while statement syntax"
.string "Invalid while statement syntax"
.string "Invalid allocate statement syntax"
.string "Invalid assembly statement syntax"
.string "Invalid writechar statement"
.string "Invalidlabel statement syntax"
.string "Incorrect ternary expression syntax"
.string "Invalid syscall expression"
.string "Too many arguments in syscall expression"
.string "Invalid readchar expression"
.string "Parantheses expression is not closed"
.string "Call expression is not closed"
.string "Index expression is not closed"
.string "Syntax error - none of available expressions matched"
.string "ERROR: string buffer is full.\n"
.string "strbuf:\n"
.string ".string "
.string "%eax"
.string "%ebx"
.string "%ecx"
.string "%edx"
.string "%esi"
.string "%edi"
.string "%ebp"
.string ".text\n"
.string ".data\n"
.string ".section .rodata\n"
.string "\tpushl "
.string "Tried to free not used register."
.string "\tpopl "
.string "Tried to pop loop from empty list."
.string "_label"
.string ":\n"
.string "ERROR: "
.string ".global "
.string "\tpushl %ebp\n"
.string "\tmovl %esp, %ebp\n"
.string "\tleave\n\tret\n"
.string ":.long "
.string "Only integers can be used for size of array"
.string ".comm "
.string "Unreachable code."
.string "\tjmp "
.string "\tcmpl $0, %eax\n"
.string "\tje "
.string "\tjne "
.string "Size must be integer in allocate statement."
.string "Size must be positive integer."
.string "\tsubl $"
.string ", %esp\n"
.string "Tried to break/continue with no loop there."
.string "\tmovl %eax, %edx\n"
.string "\taddl %eax, %edx\n"
.string "\tmovb %al, (%edx)\n"
.string "\tjmp *%eax\n"
.string "This expression can't be compiled."
.string "\tmovl %eax, %ebx\n"
.string "\tmovl %eax, "
.string "(%esp)\n"
.string "\tcall "
.string "\tcall *%ebx\n"
.string "\taddl $"
.string "\tmovl (%eax), %eax\n"
.string "\tmovl (%eax), %edx\n"
.string "\tleal "
.string "(,%eax,4), %eax\n"
.string "(%edx,%eax,4), %eax\n"
.string "\tmovl "
.string ", %eax\n"
.string "(%ebp)"
.string "\tpushl %eax\n"
.string "\tpopl %eax\n"
.string "\tint $0x80\n"
.string "\tpopl %ebp\n"
.string "\tmovsbl (%edx), %eax\n"
.string "\tnegl %eax\n"
.string "\tsete %al\n"
.string "\tmovzbl %al, %eax\n"
.string "\tnotl %eax\n"
.string "\tmovl $"
.string "Can't compile addressof for this expression."
.string "\tmovl %eax, %ecx\n"
.string "\tmovl %ebx, %eax\n"
.string "\tcltd\n"
.string "imull %ebx, %eax"
.string "idivl %ebx"
.string "idivl %ebx\n\tmovl %edx, %eax"
.string "addl %ebx, %eax"
.string "subl %ebx, %eax"
.string "shll %cl, %eax"
.string "shlr %cl, %eax"
.string "andl %ebx, %eax"
.string "xorl %ebx, %eax"
.string "orl %ebx, %eax"
.string "\tcmpl %eax, %edx\n"
.string "sete"
.string "setne"
.string "setl"
.string "setg"
.string "setle"
.string "setge"
.string " %al\n\tmovzbl %al, %eax\n"
.string "\tmovl $0, %eax\n"
.string "\tmovl $1, %eax\n"
.string "\tsubl $1, %eax\n"
.string "\taddl $1, %eax\n"
.string "1(%eax), %edx\n"
.string ", "
.string "(%ebx)"
.string "Can't use this as assignable operand."
.string "\tmovl $strbuf+"
.string "strbuf+"
.string "Expression can't be compiled as simple."
.string "usage: "
.string " [option]... <file>\n"
.string "output.S"
