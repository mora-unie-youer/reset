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
identbuf_index_error:    .string "Identifier stack is smaller than index\n"
identbuf_overflow_error: .string "Identifier stack overflow\n"
string_literals_error:   .string "Too many string literals\n"
syntax_error:            .string "Syntax error\n"

.text
/* Errors */
_identbuf_empty:
	pushl $identbuf_empty_error
	call print_error
_identbuf_index:
	pushl $identbuf_index_error
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
	cmpl $0, identbuf_depth /* If stack is empty, erroring */
	je _identbuf_empty
	decl identbuf_depth /* Decrementing depth */
	ret
_get_ident:
	movl 4(%esp), %ebx /* Fetching index */
	cmpl identbuf_depth, %ebx /* If index is bigger than depth, erroring */
	jae _identbuf_index
	movl identbuf_depth, %eax /* Fetching depth */
	subl %ebx, %eax /* Storing difference */
	decl %eax
	imul $MAX_TOKEN_LEN, %eax /* Getting offset of identifier */
	addl $identbuf, %eax /* Getting identifier address */
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
	cmpw $TOKEN_IDENTIFIER, token_tag
	je 1f
	call _constant_expr
	ret
1:
	pushl $token_text
	call _push_ident /* Pushing identifier to stack */
	addl $4, %esp
	/* Checking, what is the next character */
	call lex
	cmpw $':, token_tag
	je _function_definition
	cmpw $'(, token_tag
	je 3f
	cmpw $'[, token_tag
	je 4f
	cmpw $'=, token_tag
	je 5f
	/* If none of above listed, erroring */
	call _syntax_error
3:
	/* TODO: implement function call */
	ret
4:
	/* TODO: implement variable offsetting (indexing) */
	ret
5:
	/* TODO: implement identifier assigning */
	ret

/* Parse and compile function definition */
_function_definition:
	/* Fetching next token */
	call lex
	/* Checking if next token is (. If not -> error */
	cmpw $'(, token_tag
	jne _syntax_error
	/* Functions are written to text segment */
	call enter_text_segment
	/* Fetching identifier */
	pushl $0
	call _get_ident
	/* Printing identifier */
	movl %eax, (%esp)
	call puts
	/* Appending colon symbol */
	movb $':, (%esp)
	call putc
	addl $4, %esp
	call newline
	/* Parsing function arguments */
	call _function_args
	/* Initializing stack pointer */
	call enter_stack
	/* TODO: parse function content */
	/* Leaving the function */
	call leave
	call newline
	call ret
	call newline
	ret

/* Parse function arguments */
_function_args:
	subl $4, %esp /* counter */
	movl $0, (%esp) /* counter=0 */
	/* Fetching next token */
	call lex
	/* If next token is ), no args, exiting */
	cmpw $'), token_tag
	je 2f
1:
	/* Checking that token is argument. If not, erroring */
	cmpw $TOKEN_ARGUMENT, token_tag
	jne _syntax_error
	/* Checking if counter and argument number are equal. If not, erroring */
	movl (%esp), %eax
	cmpl token_val, %eax
	jne _syntax_error
	/* Incrementing counter */
	incl (%esp)
	/* Fetching next token */
	call lex
	/* If not equal to comma symbol, trying to exit. */
	jne 2f
	/* Fetching next token and iterating again */
	call lex
	jmp 1b
2:
	/* Trying to exit. Checking if token is ). If not, erroring */
	cmpw $'), token_tag
	jne _syntax_error
	/* Returning argument count */
	movl (%esp), %eax
	addl $4, %esp
	ret

/* Parse and compile consant expressions */
_constant_expr:
	/* TODO: implement expressions like integers and strings */

	/* If nothing was parsed, syntax erroring */
	call _syntax_error
