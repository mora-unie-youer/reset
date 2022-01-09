.data
/* Read buffer size */
.equ RDBUFSZ, 512
/* Write buffer size */
.equ WRBUFSZ, 512

/* File descriptor to which output will be written */
.global output_fd
output_fd: .long 1 /* stdout */

/* Read buffer */
.comm rdbuf, RDBUFSZ, 1
rdbuf_idx: .long 0
rdbuf_end: .long 0

/* Write buffer */
.comm wrbuf, WRBUFSZ, 1
wrbuf_idx: .long 0


.text
_read:
	/* Filling read buffer */
	movl $0x3, %eax /* syscall=0x3 (read) */
	movl $0x0, %ebx /* fd=0 (stdin) */
	movl $rdbuf, %ecx /* output_addr=rdbuf */
	movl $RDBUFSZ, %edx /* count=RDBUFSIZE */
	int $0x80 /* calling the interrupt */
	ret

.global getc
/* Get char. Supports only stdin */
getc:
	/* Checking if read buffer is exhausted */
	movl rdbuf_idx, %ebx
	cmpl %ebx, rdbuf_end
	jne 1f
	call _read
	/* If nothing was read, return EOF */
	cmpl $0, %eax
	jbe 2f
	movl %eax, rdbuf_end
1:
	xorl %eax, %eax /* we are storing char in %eax */
	movb rdbuf(%ebx), %al /* ebx stores either 0 or rdbuf_idx */
	leal 1(%ebx), %ebx /* incrementing rdbuf_idx */
	movl %ebx, rdbuf_idx /* storing it */
	ret
2:
	movb $-1, %al /* returning EOF */
	ret

/* Looks ahead next character */
.global nextc
nextc:
	/* Checking if read buffer is exhausted */
	movl rdbuf_idx, %ebx
	cmpl %ebx, rdbuf_end
	jne 1f
	call _read
	/* If nothing was read, return EOF */
	cmpl $0, %eax
	jbe 2f
	movl %eax, rdbuf_end
1:
	xorl %eax, %eax /* we are storing char in %eax */
	movb rdbuf(%ebx), %al /* ebx stores either 0 or rdbuf_idx */
	ret
2:
	movb $-1, %al /* returning EOF */
	ret

/* Prints to output fd */
.global flush
flush:
	cmpl $0, wrbuf_idx
	je 1f
	movl $0x4, %eax /* syscall=0x4 (write) */
	movl output_fd, %ebx /* fd=output_fd */
	movl $wrbuf, %ecx /* buf=wrbuf */
	movl wrbuf_idx, %edx /* count=wrbuf_idx */
	int $0x80 /* calling the interrupt */
	movl $0, wrbuf_idx /* resetting index */
1:
	ret

/* Print char */
.global putc
putc:
	pushl %ebp
	movl %esp, %ebp
	movb 8(%ebp), %al /* char to print */
	movl wrbuf_idx, %ebx
	movb %al, wrbuf(%ebx) /* storing the char in wrbuf */
	leal 1(%ebx), %ebx /* incrementing index */
	movl %ebx, wrbuf_idx /* storing it */
	/* Checking if we have to flush */
	cmpl $WRBUFSZ, %ebx
	je 1f /* if buffer is full -> flushing */
	cmpb $'\n, %al
	jne 2f /* if char newline -> flushing */
1:
	call flush
2:
	leave
	ret

/* Print string */
.global puts
puts:
	pushl %ebp
	movl %esp, %ebp
	subl $5, %esp /* (ch, str) */
	movl 8(%ebp), %ebx /* string to print */
1:
	/* Getting char from string */
	movb (%ebx), %al
	/* If zero -> string ended */
	cmpb $0, %al
	je 2f
	/* Printing char */
	movl %ebx, -4(%ebp) /* backing up %ebx */
	movb %al, -5(%ebp)  /* passing char as argument */
	call putc           /* printing the char */
	movl -4(%ebp), %ebx /* restoring the %ebx */
	addl $1, %ebx       /* moving to next char */
	jmp 1b
2:
	leave
	ret

/* Buffer for storing integer */
.comm putd_buf, 10, 1
/* Print decimal number */
.global putd
putd:
	pushl %ebp
	movl %esp, %ebp
	subl $5, %esp /* digit, offset */
	movl 8(%ebp), %eax /* number */
	xorl %ecx, %ecx /* putd_buf offset */
1:
	/* Dividing number by 10 */
	xorl %edx, %edx
	movl $10, %ebx
	idiv %ebx
	movb %dl, putd_buf(%ecx) /* Store number in buffer */
	incl %ecx /* increase offset */
	cmpl $0, %eax /* if %eax != 0, then next iteration */
	jne 1b
2:
	decl %ecx /* decreasing offset */
	movl %ecx, -4(%ebp) /* backing up offset */
	movb putd_buf(%ecx), %al /* fetching digit */
	addb $'0, %al /* adding '0 to get digit character */
	movb %al, -5(%ebp) /* passing digit as argument */
	call putc /* printing digit */
	movl -4(%ebp), %ecx /* restoring offset */
	cmpl $0, %ecx /* if offset != 0, then next iteration */
	jne 2b
	leave
	ret

/* Compare two strings */
.global strcmp
strcmp:
	pushl %ebp
	movl %esp, %ebp
	/* Two strings in arguments */
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
1:
	/* Fetching two chars */
	movb (%eax), %cl
	movb (%ebx), %dl
	/* If they are not equal -> return 0 */
	cmpb %cl, %dl
	jne 1f
	/* If they are ended (then equal) -> return 1 */
	cmpb $0, %cl
	je 2f
	/* Making next iteration */
	incl %eax
	incl %ebx
	jmp 1b
1:
	movl $0, %eax
	jmp 1f
2:
	movl $1, %eax
1:
	leave
	ret

/* Copy one string to another */
.global strcpy
strcpy:
	pushl %ebp
	movl %esp, %ebp
	/* Two strings in arguments */
	movl 8(%ebp), %eax /* dest */
	movl 12(%ebp), %ebx /* src */
1:
	movb (%ebx), %cl
	movb %cl, (%eax) /* Copying char */
	cmpb $0, %cl /* Checking if string ended */
	je 1f
	/* Making next iteration */
	incl %eax
	incl %ebx
	jmp 1b
1:
	leave
	ret

.global exit
exit:
	movl $0x1, %eax    /* syscall=0x1 (exit) */
	movl 4(%esp), %ebx /* exit code */
	int $0x80          /* calling syscall */
