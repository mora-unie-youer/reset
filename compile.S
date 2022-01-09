.include "token.S"

.data
/* String literals buffer */
.equ STRBUFSZ, 16384 /* NOTE: may be changed in future */
.comm strbuf, STRBUFSZ, 1


.section .rodata
/* Error messages */
string_literals_error: .string "Too many string literals\n"


.text
/* Errors */
_string_literals:
	pushl $string_literals_error
	call print_error

/* Entry point of compiler */
.global compile
compile:
	/* Read first token */
	call lex
	/* If EOF, ending */
	cmpw $TOKEN_END, token_tag
	je 1f
	/* TODO: Compile program */
1:
	ret
