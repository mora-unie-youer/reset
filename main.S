.text
.global _start
_start:
	movl $0x1, %eax /* interrupt = 0x1 (exit) */
	xorl %ebx, %ebx /* exit code = 0 */
	int $0x80       /* calling interrupt */
