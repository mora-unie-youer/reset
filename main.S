.text
.global _start
_start:
	call compile
	pushl $0x0
	call exit
