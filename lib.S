.text
.global exit
exit:
	movl $0x1, %eax    /* syscall=0x1 (exit) */
	movl 4(%esp), %ebx /* exit code */
	int $0x80          /* calling syscall */
