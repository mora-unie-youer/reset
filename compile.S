.include "token.S"

.data
/* String literals buffer */
.equ STRBUFSZ, 16384 /* NOTE: may be changed in future */
.comm strbuf, STRBUFSZ, 1

/* Identifier stack */
.equ IDENTBUFSZ, 16
.comm identbuf, MAX_TOKEN_LEN * IDENTBUFSZ, 1
identbuf_depth: .long 0

.section .rodata
/* Error messages */
identbuf_empty_error:    .string "Identifier stack is empty\n"
identbuf_overflow_error: .string "Identifier stack overflow\n"
string_literals_error:   .string "Too many string literals\n"
syntax_error:            .string "Syntax error\n"

.text
/* Errors */
_identbuf_empty:
	pushl $identbuf_empty_error
	call print_error
_identbuf_overflow:
	pushl $identbuf_overflow_error
	call print_error
_string_literals:
	pushl $string_literals_error
	call print_error
_syntax_error:
	pushl $syntax_error
	call print_error

/* Identifier stack */
_push_ident:
	cmpl $IDENTBUFSZ, identbuf_depth
	je _identbuf_overflow
	movl 4(%esp), %eax /* identifier */
	pushl %eax /* Pushing identifier as argument */
	movl identbuf_depth, %eax /* Loading stack depth */
	incl identbuf_depth /* Incrementing depth */
	imul $MAX_TOKEN_LEN, %eax /* Getting offset of identifier */
	addl $identbuf, %eax /* Getting identifier address */
	pushl %eax /* Pushing address as argument */
	call strcpy /* Copying data */
	addl $8, %esp
	ret
_pop_ident:
	cmpl $0, identbuf_depth
	je _identbuf_empty
	decl identbuf_depth
	ret

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
	jne _syntax_error
	/* Looking for next token */
	call lex
	/* If not EOF, continuing the loop */
	cmpw $TOKEN_END, token_tag
	jne 2b
1:
	ret

/* Parse and compile expressions */
_expr:
	/* TODO: implement expressions like if, else, allocate in this function */
	call _toplevel_expr
	ret

/* Parse and compile top-level expressions */
_toplevel_expr:
	/* TODO: implement expressions like identifiers, arguments and variables */
	call _simple_expr
	ret

/* Parse and compile 'simple' expressions */
_simple_expr:
	/* TODO: implement expressions like function calling */
	call _constant_expr
	ret

/* Parse and compile consant expressions */
_constant_expr:
	/* TODO: implement expressions like integers and strings */

	/* If nothing was parsed, syntax erroring */
	call _syntax_error
