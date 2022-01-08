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
.global exit
exit:
	movl $0x1, %eax    /* syscall=0x1 (exit) */
	movl 4(%esp), %ebx /* exit code */
	int $0x80          /* calling syscall */
