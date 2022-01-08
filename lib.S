.data
/* Read buffer size */
.equ RDBUFSZ, 512
/* Write buffer size */
.equ WRBUFSZ, 512

/* File descriptor to which output will be written */
.global output_fd

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
	movl $-1, %eax /* returning EOF */
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
	movl $-1, %eax /* returning EOF */
	ret

.global exit
exit:
	movl $0x1, %eax    /* syscall=0x1 (exit) */
	movl 4(%esp), %ebx /* exit code */
	int $0x80          /* calling syscall */
