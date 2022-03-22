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
	pushl %edx
	movl 8(%ebp), %eax
	pushl %eax
	movl 16(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	cltd
	idiv %ebx
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
	idiv %ebx
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
	pushl %edx
	movl 8(%ebp), %eax
	pushl %eax
	movl 16(%ebp), %eax
	movl %eax, %ebx
	popl %eax
	cltd
	idiv %ebx
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
	idiv %ebx
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
	je _label40
	subl $4, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	jmp _label41
_label40:
	subl $4, %esp
	movl $strbuf+113, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
_label41:
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
reserved_keywords:.long strbuf+130,strbuf+133,strbuf+138,strbuf+144,strbuf+150,strbuf+159,strbuf+166,strbuf+174,strbuf+181,strbuf+186,strbuf+192,strbuf+201,strbuf+211,strbuf+216,strbuf+220,0
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
	movl $strbuf+228, %eax
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
	movl $strbuf+261, %eax
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
	movl %eax, %ebx
	pushl %ebx
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call lexer_look
	addl $4, %esp
	popl %ebx
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	addl %ebx, %eax
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
	je _label46
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
	jmp _label47
_label46:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $65, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label48
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
	jmp _label49
_label48:
	movl -4(%ebp), %eax
	pushl %eax
	movl $48, %eax
	movl %eax, %ebx
	popl %eax
	subl %ebx, %eax
	movl %eax, -4(%ebp)
_label49:
_label47:
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
_label50:
	movl -8(%ebp), %eax
	leal reserved_keywords(,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label51
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
	je _label52
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
_label52:
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -8(%ebp)
	jmp _label50
_label51:
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
	je _label53
	movl $260, %eax
	movl %eax, -8(%ebp)
_label53:
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
	je _label54
	movl $le06, %eax
	jmp *%eax
_label54:
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
	je _label55
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label56
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
_label56:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $62, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label57
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
_label57:
_label55:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $33, %eax
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
	je _label59
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
_label59:
_label58:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $43, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label60
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label61
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
_label61:
_label60:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $45, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label62
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label63
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
_label63:
_label62:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $42, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label64
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
	movl $311, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label65:
_label64:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $47, %eax
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
	je _label67
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
_label67:
_label66:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $37, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label68
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label69
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
_label69:
_label68:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $60, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label70
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label71
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
_label71:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $60, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label72
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label73
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
	jmp _label74
_label73:
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
_label74:
_label72:
_label70:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $62, %eax
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
	je _label76
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
_label76:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $62, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label77
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label78
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
	jmp _label79
_label78:
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
_label79:
_label77:
_label75:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $94, %eax
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
	je _label81
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
_label81:
_label80:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $38, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label82
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $38, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label83
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
_label83:
	movl -8(%ebp), %eax
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
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $314, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label84:
_label82:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $124, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label85
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $124, %eax
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
	movl $308, %eax
	movl %eax, 4(%esp)
	call lexer_token_set
	addl $8, %esp
_label86:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $61, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label87
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
_label87:
_label85:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $35, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label88
_label89:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $10, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	imull %ebx, %eax
	cmpl $0, %eax
	je _label90
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
	jmp _label89
_label90:
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
_label88:
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
	movl $strbuf+264, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le01:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+282, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le02:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+307, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le03:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+349, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le04:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+395, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le05:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+425, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le06:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+473, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
le07:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+504, %eax
	movl %eax, 4(%esp)
	call lexer_error
	addl $8, %esp
	leave
	ret
parser:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
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
	call tuple3
	addl $12, %esp
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
	movl $strbuf+261, %eax
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
_label91:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $256, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label92
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label93
	movl $parser_parse_continue, %eax
	jmp *%eax
_label93:
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
	je _label94
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_push
	addl $8, %esp
_label94:
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
	je _label95
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
	je _label96
	movl $parser_parse_error, %eax
	jmp *%eax
_label96:
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
_label95:
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lex
	addl $4, %esp
	movl %eax, -8(%ebp)
	jmp _label91
_label92:
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
	je _label97
	movl $parser_parse_continue, %eax
	jmp *%eax
_label97:
	movl -4(%ebp), %eax
	leave
	ret
parser_parse_error:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+532, %eax
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
	movl $277, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label98
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call global_statement
	addl $8, %esp
	leave
	ret
_label98:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $284, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label99
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call include_statement
	addl $8, %esp
	leave
	ret
_label99:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $258, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label100
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
	je _label101
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
_label101:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $58, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label102
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
	je _label103
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
_label103:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $91, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label104
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
_label104:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $282, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label105
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $57, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call type_array_declaration
	addl $16, %esp
	leave
	ret
_label105:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $283, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label106
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $58, %eax
	movl %eax, 8(%esp)
	movl 16(%ebp), %eax
	movl %eax, 12(%esp)
	call type_array_declaration
	addl $16, %esp
	leave
	ret
_label106:
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
_label102:
_label100:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+570, %eax
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
	je _label107
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
	jmp _label108
_label107:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label109
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
	je _label110
	movl $global_statement_invalid, %eax
	jmp *%eax
_label110:
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
	je _label111
	movl $global_statement_next, %eax
	jmp *%eax
_label111:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label112
	movl $global_statement_invalid, %eax
	jmp *%eax
_label112:
	jmp _label113
_label109:
	movl $global_statement_invalid, %eax
	jmp *%eax
_label113:
_label108:
	subl $12, %esp
	movl $53, %eax
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
	movl $strbuf+632, %eax
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
	je _label114
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
	jmp _label115
_label114:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label116
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
	je _label117
	movl $include_statement_invalid, %eax
	jmp *%eax
_label117:
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
	je _label118
	movl $include_statement_next, %eax
	jmp *%eax
_label118:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label119
	movl $include_statement_invalid, %eax
	jmp *%eax
_label119:
	jmp _label120
_label116:
	movl $include_statement_invalid, %eax
	jmp *%eax
_label120:
_label115:
	movl $0, %eax
	movl %eax, -8(%ebp)
_label121:
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
	je _label122
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	movl %eax, -12(%ebp)
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
	movl -12(%ebp), %eax
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
	movl -8(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -8(%ebp)
	jmp _label121
_label122:
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
	movl $strbuf+657, %eax
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
	movl $54, %eax
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
	je _label123
	movl $function_declaration_arg_end, %eax
	jmp *%eax
_label123:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $260, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label124
	movl $function_declaration_arg_invalid, %eax
	jmp *%eax
_label124:
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
	je _label125
	movl $function_declaration_arg_invalid, %eax
	jmp *%eax
_label125:
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
	je _label126
	movl $function_declaration_arg_loop, %eax
	jmp *%eax
_label126:
function_declaration_arg_end:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label127
	movl $function_declaration_arg_invalid, %eax
	jmp *%eax
_label127:
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
	movl $55, %eax
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
	movl $strbuf+683, %eax
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
	je _label128
	movl $array_declaration_loop, %eax
	jmp *%eax
_label128:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $93, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label129
	movl $array_declaration_invalid, %eax
	jmp *%eax
_label129:
	subl $16, %esp
	movl $56, %eax
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
	movl $strbuf+729, %eax
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
	je _label130
	movl $type_array_declaration_invalid, %eax
	jmp *%eax
_label130:
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
	je _label131
	movl $type_array_declaration_invalid, %eax
	jmp *%eax
_label131:
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
	movl $strbuf+762, %eax
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
	movl $59, %eax
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
	je _label132
	movl $block_statement_invalid, %eax
	jmp *%eax
_label132:
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
	je _label133
	movl $block_statement_end, %eax
	jmp *%eax
_label133:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $123, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label134
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	call block_statement
	addl $8, %esp
	movl %eax, -12(%ebp)
	jmp _label135
_label134:
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
_label135:
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
	je _label136
	movl $block_statement_content_invalid, %eax
	jmp *%eax
_label136:
	movl $block_statement_loop, %eax
	jmp *%eax
block_statement_end:
	subl $12, %esp
	movl $52, %eax
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
	movl $strbuf+800, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
block_statement_content_invalid:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -20(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+831, %eax
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
	je _label137
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call if_statement
	addl $8, %esp
	leave
	ret
_label137:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $273, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label138
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call while_statement
	addl $8, %esp
	leave
	ret
_label138:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $274, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label139
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call allocate_statement
	addl $8, %esp
	leave
	ret
_label139:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $275, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label140
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call return_statement
	addl $8, %esp
	leave
	ret
_label140:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $281, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label141
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call writechar_statement
	addl $8, %esp
	leave
	ret
_label141:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $279, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label142
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call label_statement
	addl $8, %esp
	leave
	ret
_label142:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $278, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label143
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call goto_statement
	addl $8, %esp
	leave
	ret
_label143:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call expression
	addl $8, %esp
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
	je _label144
	movl $if_statement_invalid, %eax
	jmp *%eax
_label144:
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
	je _label145
	movl $if_statement_invalid, %eax
	jmp *%eax
_label145:
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
	je _label146
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl $if_statement_end, %eax
	jmp *%eax
_label146:
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
if_statement_end:
	subl $12, %esp
	movl $45, %eax
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
	movl $strbuf+882, %eax
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
	je _label147
	movl $while_statement_invalid, %eax
	jmp *%eax
_label147:
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
	je _label148
	movl $while_statement_invalid, %eax
	jmp *%eax
_label148:
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
	movl $46, %eax
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
	movl $strbuf+910, %eax
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
	je _label149
	movl $allocate_statement_invalid, %eax
	jmp *%eax
_label149:
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
	je _label150
	movl $allocate_statement_invalid, %eax
	jmp *%eax
_label150:
	subl $12, %esp
	movl $47, %eax
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
	movl $strbuf+941, %eax
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
	je _label151
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call parser_lexer_hold
	addl $4, %esp
	movl $return_statement_end, %eax
	jmp *%eax
_label151:
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
	movl $48, %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl -4(%ebp), %eax
	movl %eax, 8(%esp)
	call tuple3
	addl $12, %esp
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
	je _label152
	movl $writechar_statement_invalid, %eax
	jmp *%eax
_label152:
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
	je _label153
	movl $writechar_statement_invalid, %eax
	jmp *%eax
_label153:
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
	je _label154
	movl $writechar_statement_invalid, %eax
	jmp *%eax
_label154:
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
	je _label155
	movl $writechar_statement_invalid, %eax
	jmp *%eax
_label155:
	subl $20, %esp
	movl $49, %eax
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
	movl $strbuf+975, %eax
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
	je _label156
	movl $label_statement_invalid, %eax
	jmp *%eax
_label156:
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
	movl $50, %eax
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
	movl $strbuf+1003, %eax
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
	movl $51, %eax
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
	je _label157
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
_label157:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $309, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label158
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
_label158:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $310, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label159
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
_label159:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $311, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label160
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
_label160:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $312, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label161
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
_label161:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $313, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label162
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
_label162:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $314, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label163
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
_label163:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $315, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label164
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
_label164:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $316, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label165
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
_label165:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $317, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label166
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
_label166:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $318, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label167
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
_label167:
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
	je _label168
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
_label168:
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
	je _label169
	movl $ternary_expr_error, %eax
	jmp *%eax
_label169:
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
	movl $44, %eax
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
	movl $strbuf+1033, %eax
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
	je _label170
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
_label170:
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
	je _label171
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
_label171:
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
	je _label172
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
_label172:
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
	je _label173
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
_label173:
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
	je _label174
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
_label174:
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
	je _label175
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $26, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call equality_expr
	addl $16, %esp
	leave
	ret
_label175:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $301, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label176
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $27, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call equality_expr
	addl $16, %esp
	leave
	ret
_label176:
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
	je _label177
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
_label177:
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
	je _label178
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $22, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call relational_expr
	addl $16, %esp
	leave
	ret
_label178:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $62, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label179
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $23, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call relational_expr
	addl $16, %esp
	leave
	ret
_label179:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $302, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label180
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $24, %eax
	movl %eax, 8(%esp)
	movl 20(%ebp), %eax
	movl %eax, 12(%esp)
	call relational_expr
	addl $16, %esp
	leave
	ret
_label180:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $303, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label181
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
_label181:
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
	je _label182
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
_label182:
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
	je _label183
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
_label183:
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
	movl $30, %eax
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
	je _label184
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
_label184:
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
	je _label185
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
_label185:
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
	movl $29, %eax
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
	je _label186
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
_label186:
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
	je _label187
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
_label187:
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
	movl $28, %eax
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
	je _label188
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
_label188:
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
	je _label189
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
_label189:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $306, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label190
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
_label190:
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
	je _label191
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
_label191:
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
	je _label192
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
_label192:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $45, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label193
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
_label193:
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
	je _label194
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
_label194:
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
	je _label195
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
_label195:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $47, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label196
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
_label196:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $37, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label197
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
_label197:
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
	je _label198
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
_label198:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $45, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label199
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
_label199:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $33, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label200
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
_label200:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $126, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label201
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
_label201:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $42, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label202
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
_label202:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $38, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label203
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
_label203:
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
	je _label204
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call simple_identifier_expression
	addl $8, %esp
	leave
	ret
_label204:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $260, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label205
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
_label205:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $261, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label206
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
_label206:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $276, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label207
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call simple_syscall_expression
	addl $8, %esp
	leave
	ret
_label207:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $280, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label208
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call simple_readchar_expression
	addl $8, %esp
	leave
	ret
_label208:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label209
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call simple_parantheses_expression
	addl $8, %esp
	leave
	ret
_label209:
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
	je _label210
	movl $3, %eax
	movl %eax, -4(%ebp)
_label210:
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
	je _label211
	movl $simple_syscall_expression_invalid, %eax
	jmp *%eax
_label211:
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
	je _label212
	movl $simple_syscall_expression_loop, %eax
	jmp *%eax
_label212:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label213
	movl $simple_syscall_expression_invalid, %eax
	jmp *%eax
_label213:
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
	je _label214
	movl $simple_syscall_expression_too_many, %eax
	jmp *%eax
_label214:
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
	movl $strbuf+1069, %eax
	movl %eax, 8(%esp)
	call parser_error
	addl $12, %esp
simple_syscall_expression_too_many:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1096, %eax
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
	je _label215
	movl $simple_readchar_expression_invalid, %eax
	jmp *%eax
_label215:
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
	je _label216
	movl $simple_readchar_expression_invalid, %eax
	jmp *%eax
_label216:
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
	je _label217
	movl $simple_readchar_expression_invalid, %eax
	jmp *%eax
_label217:
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
	movl $strbuf+1137, %eax
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
	je _label218
	movl $simple_parantheses_expression_invalid, %eax
	jmp *%eax
_label218:
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
	movl $strbuf+1165, %eax
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
	je _label219
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
_label219:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $91, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label220
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
_label220:
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
	je _label221
	movl $simple_address_call_expression_end, %eax
	jmp *%eax
_label221:
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
	je _label222
	movl $simple_address_call_expression_loop, %eax
	jmp *%eax
_label222:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label223
	movl $simple_address_call_expression_invalid, %eax
	jmp *%eax
_label223:
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
	movl $strbuf+1202, %eax
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
	je _label224
	movl $simple_address_index_expression_invalid, %eax
	jmp *%eax
_label224:
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
	movl $strbuf+1232, %eax
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
	je _label225
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call constant_integer_expression
	addl $8, %esp
	leave
	ret
_label225:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $259, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label226
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	call constant_string_expression
	addl $8, %esp
	leave
	ret
_label226:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 16(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1263, %eax
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
	je _label227
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
_label228:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl -8(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label229
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
	je _label230
	movl -16(%ebp), %eax
	leave
	ret
_label230:
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
	jmp _label228
_label229:
_label227:
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
	je _label231
	movl -4(%ebp), %eax
	leave
	ret
_label231:
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
	je _label232
	subl $4, %esp
	movl $strbuf+1316, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl $1, %eax
	movl %eax, 0(%esp)
	call exit
	addl $4, %esp
_label232:
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
	je _label233
	movl 8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, -4(%ebp)
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1347, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl $0, %eax
	movl %eax, -12(%ebp)
_label234:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl -8(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label235
	subl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1356, %eax
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
	jmp _label234
_label235:
_label233:
	leave
	ret
.data
registers:.long strbuf+1365,strbuf+1370,strbuf+1375,strbuf+1380,strbuf+1385,strbuf+1390,strbuf+1395
.text
compiler:
	pushl %ebp
	movl %esp, %ebp
	subl $20, %esp
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
	call tuple5
	addl $20, %esp
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
	je _label236
	leave
	ret
_label236:
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
	je _label237
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1400, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label237:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label238
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1407, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label238:
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label239
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1414, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label239:
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
	je _label240
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1432, %eax
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
_label240:
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
	movl $strbuf+1440, %eax
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
	je _label241
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1473, %eax
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
_label241:
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
fputlabel:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1480, %eax
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
	movl $strbuf+1487, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compiler_error:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $strbuf+1490, %eax
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
	movl $strbuf+261, %eax
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
_label242:
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
	je _label243
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
	jmp _label242
_label243:
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
_label244:
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
	je _label245
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
	movl $54, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label246
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -12(%ebp)
_label247:
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
	je _label248
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
	jmp _label247
_label248:
_label246:
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label244
_label245:
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
	je _label249
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label249:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $7, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label250
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label250:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label251
	movl $2, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label251:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $8, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label252
	movl $2, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label252:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $9, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $14, %eax
	cmpl %eax, %edx
	setle %al
	movzbl %al, %eax
	imull %ebx, %eax
	cmpl $0, %eax
	je _label253
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label253:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $15, %eax
	cmpl %eax, %edx
	setge %al
	movzbl %al, %eax
	movl %eax, %ebx
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $43, %eax
	cmpl %eax, %edx
	setle %al
	movzbl %al, %eax
	imull %ebx, %eax
	cmpl $0, %eax
	je _label254
	movl $2, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label254:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label255
	movl $3, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label255:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $45, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label256
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label256:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $52, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label257
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label257:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $48, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label258
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label258:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $56, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label259
	movl $3, %eax
	movl %eax, -8(%ebp)
	movl $compiler_use_macro_vector, %eax
	jmp *%eax
_label259:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $47, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label260
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label260:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $46, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label261
	movl $2, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label261:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $49, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label262
	movl $3, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label262:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $51, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label263
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label263:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $54, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label264
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label264:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $55, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label265
	movl $4, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label265:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $57, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label266
	movl $3, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label266:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $58, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label267
	movl $3, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label267:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label268
	movl $3, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl $compiler_use_macro_tuple, %eax
	jmp *%eax
_label268:
compiler_use_macro_exit:
	leave
	ret
compiler_use_macro_tuple:
	movl $0, %eax
	movl %eax, -4(%ebp)
_label269:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl -12(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label270
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
	je _label271
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
	je _label272
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
_label272:
	jmp _label273
_label271:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call compiler_use_macro
	addl $12, %esp
_label273:
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label269
_label270:
	movl $compiler_use_macro_exit, %eax
	jmp *%eax
compiler_use_macro_vector:
	movl $0, %eax
	movl %eax, -4(%ebp)
_label274:
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
	je _label275
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
	je _label276
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
	je _label277
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
_label277:
	jmp _label278
_label276:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -16(%ebp), %eax
	movl %eax, 4(%esp)
	movl 16(%ebp), %eax
	movl %eax, 8(%esp)
	call compiler_use_macro
	addl $12, %esp
_label278:
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label274
_label275:
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
	movl $53, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label279
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_global_statement
	addl $8, %esp
_label279:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $55, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label280
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_function_declaration
	addl $8, %esp
_label280:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $56, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label281
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_array_declaration
	addl $8, %esp
_label281:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $57, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label282
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $1, %eax
	movl %eax, 8(%esp)
	call compile_type_array_declaration
	addl $12, %esp
_label282:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $58, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label283
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $4, %eax
	movl %eax, 8(%esp)
	call compile_type_array_declaration
	addl $12, %esp
_label283:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $59, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label284
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_variable_declaration
	addl $8, %esp
_label284:
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
	movl $strbuf+1498, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl $0, %eax
	movl %eax, -8(%ebp)
_label285:
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
	je _label286
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label287
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $44, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label287:
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
	jmp _label285
_label286:
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
	movl $strbuf+1487, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1507, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1520, %eax
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
	je _label288
	movl $compile_function_declaration_return_print, %eax
	jmp *%eax
_label288:
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
	movl $48, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label289
	leave
	ret
_label289:
compile_function_declaration_return_print:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1538, %eax
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
	movl $strbuf+1551, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl $0, %eax
	movl %eax, -8(%ebp)
_label290:
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
	je _label291
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label292
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $44, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
_label292:
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
	jmp _label290
_label291:
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
	je _label293
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1559, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label293:
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
	movl $strbuf+1603, %eax
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
	movl $strbuf+1551, %eax
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
	subl $12, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
_label294:
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
	je _label295
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
	movl -8(%ebp), %eax
	cmpl $0, %eax
	je _label296
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $50, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label297
	movl $0, %eax
	movl %eax, -8(%ebp)
	jmp _label298
_label297:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1610, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label298:
_label296:
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
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $48, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	movl %eax, %ebx
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $51, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	addl %ebx, %eax
	cmpl $0, %eax
	je _label299
	movl $1, %eax
	movl %eax, -8(%ebp)
_label299:
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -4(%ebp)
	jmp _label294
_label295:
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
	movl $45, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label300
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_if_statement
	addl $8, %esp
	leave
	ret
_label300:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $46, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label301
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_while_statement
	addl $8, %esp
	leave
	ret
_label301:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $47, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label302
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_allocate_statement
	addl $8, %esp
	leave
	ret
_label302:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $48, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label303
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_return_statement
	addl $8, %esp
	leave
	ret
_label303:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $49, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label304
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_writechar_statement
	addl $8, %esp
	leave
	ret
_label304:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $50, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label305
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_label_statement
	addl $8, %esp
	leave
	ret
_label305:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $51, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label306
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_goto_statement
	addl $8, %esp
	leave
	ret
_label306:
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_expression
	addl $8, %esp
	leave
	ret
compile_if_statement:
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
	movl %eax, -12(%ebp)
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
	movl $0, %eax
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
	movl $strbuf+1660, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1676, %eax
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
	movl $1, %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call compile_block_statement
	addl $8, %esp
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
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label307
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call compiler_new_label
	addl $4, %esp
	movl %eax, -8(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1681, %eax
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
	movl $2, %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	popl %edi
	popl %esi
	popl %edx
	popl %ecx
	popl %ebx
	movl %eax, 4(%esp)
	call compile_block_statement
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, -12(%ebp)
_label307:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl -12(%ebp), %eax
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
	movl $strbuf+1660, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1676, %eax
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
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1681, %eax
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
	je _label308
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1687, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label308:
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
	je _label309
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1731, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
_label309:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1762, %eax
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
	movl $strbuf+1770, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
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
	je _label310
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
_label310:
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
	movl $strbuf+1538, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
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
	movl $strbuf+1778, %eax
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
	movl $strbuf+1796, %eax
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
	movl $strbuf+1814, %eax
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
	movl $strbuf+1487, %eax
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
	movl $strbuf+1833, %eax
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
	je _label311
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_integer_expression
	addl $8, %esp
_label311:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label312
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_string_expression
	addl $8, %esp
_label312:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $7, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label313
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_address_call_expression
	addl $8, %esp
_label313:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $8, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label314
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_address_index_expression
	addl $8, %esp
_label314:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label315
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_simple_identifier_expression
	addl $8, %esp
_label315:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label316
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_simple_argument_expression
	addl $8, %esp
_label316:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label317
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_simple_variable_expression
	addl $8, %esp
_label317:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label318
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_simple_syscall_expression
	addl $8, %esp
_label318:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label319
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_simple_readchar_expression
	addl $8, %esp
_label319:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $9, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label320
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_plus_expression
	addl $8, %esp
_label320:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $10, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label321
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_minus_expression
	addl $8, %esp
_label321:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $11, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label322
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_logical_not_expression
	addl $8, %esp
_label322:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $12, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label323
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_not_expression
	addl $8, %esp
_label323:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $13, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label324
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_deref_expression
	addl $8, %esp
_label324:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $14, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label325
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_prefix_addrof_expression
	addl $8, %esp
_label325:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $15, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label326
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_bitwise_arithmetic_expression
	addl $8, %esp
_label326:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $16, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label327
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	call compile_division_expression
	addl $12, %esp
_label327:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $17, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label328
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $1, %eax
	movl %eax, 8(%esp)
	call compile_division_expression
	addl $12, %esp
_label328:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $18, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label329
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_bitwise_arithmetic_expression
	addl $8, %esp
_label329:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $19, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label330
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_bitwise_arithmetic_expression
	addl $8, %esp
_label330:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $20, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label331
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	call compile_bitwise_shift_expression
	addl $12, %esp
_label331:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $21, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label332
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $1, %eax
	movl %eax, 8(%esp)
	call compile_bitwise_shift_expression
	addl $12, %esp
_label332:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $28, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label333
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_bitwise_arithmetic_expression
	addl $8, %esp
_label333:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $29, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label334
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_bitwise_arithmetic_expression
	addl $8, %esp
_label334:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $30, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label335
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_bitwise_arithmetic_expression
	addl $8, %esp
_label335:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $22, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label336
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
_label336:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $23, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label337
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
_label337:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $24, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label338
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
_label338:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $25, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label339
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
_label339:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $26, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label340
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
_label340:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $27, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label341
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_comparison_expression
	addl $8, %esp
_label341:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $31, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label342
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $0, %eax
	movl %eax, 8(%esp)
	call compile_logical_expression
	addl $12, %esp
_label342:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $32, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label343
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $1, %eax
	movl %eax, 8(%esp)
	call compile_logical_expression
	addl $12, %esp
_label343:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $44, %eax
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
	call compile_ternary_expression
	addl $8, %esp
_label344:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $33, %eax
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
	call compile_assignment_expression
	addl $8, %esp
_label345:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $34, %eax
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
	call compile_assignment_expression
	addl $8, %esp
_label346:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $35, %eax
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
	call compile_assignment_expression
	addl $8, %esp
_label347:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $36, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label348
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_assignment_expression
	addl $8, %esp
_label348:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $37, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label349
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_assignment_expression
	addl $8, %esp
_label349:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $38, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label350
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_assignment_expression
	addl $8, %esp
_label350:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $39, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label351
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_assignment_expression
	addl $8, %esp
_label351:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $40, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label352
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_assignment_expression
	addl $8, %esp
_label352:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $41, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label353
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_assignment_expression
	addl $8, %esp
_label353:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $42, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label354
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_assignment_expression
	addl $8, %esp
_label354:
	movl -4(%ebp), %eax
	movl %eax, %edx
	movl $43, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label355
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_assignment_expression
	addl $8, %esp
_label355:
	leave
	ret
compile_address_call_expression:
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
	movl 12(%ebp), %eax
	pushl %edx
	movl %eax, %edx
	movl $2, %eax
	leal (%edx,%eax,4), %eax
	popl %edx
	movl (%eax), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
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
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label356
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	call compile_function_call_expression
	addl $8, %esp
	leave
	ret
_label356:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+1845, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
	leave
	ret
compile_function_call_expression:
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
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
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
	je _label357
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1762, %eax
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
	movl $strbuf+1770, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label357:
	movl $1, %eax
	movl %eax, -16(%ebp)
_label358:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl -12(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label359
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
	movl $strbuf+1909, %eax
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
	movl $strbuf+1922, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl -16(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -16(%ebp)
	jmp _label358
_label359:
	subl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $0, %eax
	movl %eax, 4(%esp)
	call vector_get
	addl $8, %esp
	movl %eax, -20(%ebp)
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1930, %eax
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
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label360
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1937, %eax
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
	movl $strbuf+1770, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label360:
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
	movl $strbuf+1945, %eax
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
	je _label361
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
	movl $strbuf+1965, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label362
_label361:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	setne %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label363
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
	movl $strbuf+1778, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label363:
_label362:
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
	movl $strbuf+1985, %eax
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
	je _label364
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
	movl $strbuf+1992, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label365
_label364:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2009, %eax
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
_label365:
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
	movl $strbuf+2030, %eax
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
	movl $strbuf+2037, %eax
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
	movl $strbuf+2030, %eax
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
	movl $strbuf+2037, %eax
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
	movl $strbuf+2045, %eax
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
	movl $strbuf+2030, %eax
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
	movl $strbuf+2037, %eax
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
	movl $strbuf+2045, %eax
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
	je _label366
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
_label366:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label367
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $2, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
_label367:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label368
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
_label368:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label369
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
_label369:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label370
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $5, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
_label370:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $6, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label371
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1507, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label371:
	movl $0, %eax
	movl %eax, -16(%ebp)
_label372:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl -12(%ebp), %eax
	cmpl %eax, %edx
	setl %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label373
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
	je _label374
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1909, %eax
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
_label374:
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
	je _label375
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2052, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label375:
	movl -16(%ebp), %eax
	movl %eax, %ebx
	movl $1, %eax
	addl %ebx, %eax
	movl %eax, -16(%ebp)
	jmp _label372
_label373:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label376
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2065, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label376:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2077, %eax
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
	je _label377
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2089, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label377:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $5, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label378
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $5, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label378:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label379
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $4, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label379:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label380
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $3, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label380:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label381
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $2, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label381:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label382
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
_label382:
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
	movl $strbuf+1778, %eax
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
	movl $strbuf+1796, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2101, %eax
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
	movl $strbuf+2123, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
compile_prefix_logical_not_expression:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+2135, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
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
	movl $strbuf+2198, %eax
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
	movl $strbuf+1945, %eax
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
	je _label383
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2210, %eax
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
	movl $strbuf+2037, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
_label383:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label384
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1985, %eax
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
	movl $strbuf+2037, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
_label384:
	movl -12(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label385
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1985, %eax
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
	movl $strbuf+2037, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	leave
	ret
_label385:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+2218, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
	leave
	ret
compile_division_expression:
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
	movl $strbuf+2052, %eax
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
	movl $strbuf+2263, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2065, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2281, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2288, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl 12(%ebp), %eax
	movl %eax, %edx
	movl $0, %eax
	leal (%edx,%eax,4), %eax
	movl (%eax), %eax
	movl %eax, %edx
	movl $17, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label386
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2300, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label386:
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
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_free_register
	addl $8, %esp
	leave
	ret
compile_bitwise_shift_expression:
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
	movl $1, %eax
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
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl $2, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2318, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $9, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	movl 16(%ebp), %eax
	cmpl $0, %eax
	je _label387
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2336, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label388
_label387:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2341, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label388:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2346, %eax
	movl %eax, 4(%esp)
	call fputs
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
compile_bitwise_arithmetic_expression:
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
	movl $1, %eax
	movl %eax, 4(%esp)
	call compiler_allocate_register
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $19, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label389
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2052, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label390
_label389:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2263, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label390:
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
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $19, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label391
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2263, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2065, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label391:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $9, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $15, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label392
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2375, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label392:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $18, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label393
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2380, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label393:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $19, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label394
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2384, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label394:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $28, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label395
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2388, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label395:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $29, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label396
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2392, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label396:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $30, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label397
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2396, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label397:
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
	movl $strbuf+1778, %eax
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
	movl $strbuf+2413, %eax
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
	movl $26, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label398
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2431, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label398:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $27, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label399
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2436, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label399:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $22, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label400
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2442, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label400:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $23, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label401
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2447, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label401:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $24, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label402
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2452, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label402:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $25, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label403
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2458, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label403:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2464, %eax
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
	je _label404
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2488, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label405
_label404:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2504, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label405:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1681, %eax
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
	je _label406
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2504, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label407
_label406:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2488, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label407:
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
	je _label408
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
_label408:
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
	movl $strbuf+1660, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	movl 16(%ebp), %eax
	cmpl $0, %eax
	je _label409
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2520, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	jmp _label410
_label409:
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1676, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label410:
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
	movl $strbuf+1660, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+1676, %eax
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
	movl $strbuf+1681, %eax
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
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $33, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label411
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
	je _label412
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
	movl $strbuf+2263, %eax
	movl %eax, 4(%esp)
	call fputs
	addl $8, %esp
_label412:
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
	movl $strbuf+1909, %eax
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
	je _label413
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
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
_label413:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $3, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label414
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
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
_label414:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $4, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label415
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
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $10, %eax
	movl %eax, 4(%esp)
	call fputc
	addl $8, %esp
	leave
	ret
_label415:
	movl -16(%ebp), %eax
	movl %eax, %edx
	movl $8, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label416
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2526, %eax
	movl %eax, 4(%esp)
	call fputs
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
_label416:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+2534, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
	leave
	ret
_label411:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+2572, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
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
	movl $strbuf+2210, %eax
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
	movl $strbuf+2037, %eax
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
	movl $strbuf+2642, %eax
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
	movl $strbuf+2037, %eax
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
	je _label417
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
_label417:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $1, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label418
	subl $8, %esp
	movl -4(%ebp), %eax
	movl %eax, 0(%esp)
	movl $strbuf+2657, %eax
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
_label418:
	movl -8(%ebp), %eax
	movl %eax, %edx
	movl $2, %eax
	cmpl %eax, %edx
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je _label419
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
_label419:
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	movl 12(%ebp), %eax
	movl %eax, 4(%esp)
	movl $strbuf+2665, %eax
	movl %eax, 8(%esp)
	call compiler_error
	addl $12, %esp
	leave
	ret
usage:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $strbuf+2705, %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl 8(%ebp), %eax
	movl %eax, 0(%esp)
	call eputs
	addl $4, %esp
	subl $4, %esp
	movl $strbuf+2713, %eax
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
	je _label420
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
_label420:
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
	movl $strbuf+2734, %eax
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
.string "while"
.string "allocate"
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
.string "Invalid while statement syntax"
.string "Invalid allocate statement syntax"
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
.string "Unreachable code: already returned in this block."
.string "\tcmpl $0, %eax\n"
.string "\tje "
.string "\tjmp "
.string "Size must be integer in allocate statement."
.string "Size must be positive integer."
.string "\tsubl $"
.string ", %esp\n"
.string "\tmovl %eax, %edx\n"
.string "\taddl %eax, %edx\n"
.string "\tmovb %al, (%edx)\n"
.string "\tjmp *%eax\n"
.string "Compilation of address call expressions is not implemented yet."
.string "\tmovl %eax, "
.string "(%esp)\n"
.string "\tcall "
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
.string "Compilation of logical not expressions is not implemented yet."
.string "\tnotl %eax\n"
.string "\tmovl $"
.string "Can't compile addressof for this expression."
.string "\tmovl %eax, %ebx\n"
.string "\tcltd\n"
.string "\tidiv %ebx\n"
.string "\tmovl %edx, %eax\n"
.string "\tmovl %eax, %ecx\n"
.string "shlr"
.string "shll"
.string " %cl, %ebx\n\tmovl %ebx, %eax\n"
.string "imul"
.string "add"
.string "sub"
.string "and"
.string "xor"
.string "or"
.string "l %ebx, %eax\n"
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
.string "\tjne "
.string "(%ebx)\n"
.string "Can't use this as assignable operand."
.string "Compilation of complex assignment expressions is not implemented yet."
.string "\tmovl $strbuf+"
.string "strbuf+"
.string "Expression can't be compiled as simple."
.string "usage: "
.string " [option]... <file>\n"
.string "output.S"
