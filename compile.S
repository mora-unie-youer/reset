.include "token.S"

.data
/* String literals buffer */
.equ STRBUFSZ, 16384 /* NOTE: may be changed in future */
.comm strbuf, STRBUFSZ, 1


.section .rodata
/* Error messages */
string_literals_error: .string "Too many string literals\n"
syntax_error:          .string "Syntax error\n"

.text
/* Errors */
_string_literals:
	pushl $string_literals_error
	call print_error
_syntax_error:
	pushl $syntax_error
	call print_error

/* Entry point of compiler */
.global compile
compile:
	/* Read first token */
	call lex
	/* If EOF, ending */
	cmpw $TOKEN_END, token_tag
	je 1f
2:
	/* Compile program */
	call _expr /* Compile expression */
	call lex   /* Looking for next token */
	cmpw $TOKEN_END, token_tag /* If EOF, ending */
	je 1f
	/* If next token is not ;, invalid syntax */
	cmpw $';, token_tag
	je 3f
	/* Not valid syntax, erroring */
	call _syntax_error
3:
	/* Looking for next token */
	call lex
	/* If not EOF, continuing the loop */
	cmpw $TOKEN_END, token_tag
	jne 2b
1:
	ret

/* Parse and compile expression */
_expr:
	ret
