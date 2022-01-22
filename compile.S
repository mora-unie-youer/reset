.include "token.S"

.data
/* String literals buffer */
.equ STRBUFSZ, 16384 /* NOTE: may be changed in future */
.comm strbuf, STRBUFSZ, 1
/* Offset to next string */
strbuf_offset: .long 0
/* Current string buffer length */
strbuf_length: .long 0
strbuf_text:   .string "strbuf"

/* Identifier stack */
.equ IDENTBUFSZ, 16
.comm identbuf, MAX_TOKEN_LEN * IDENTBUFSZ, 1
identbuf_depth: .long 0

/* Label ID */
label_id: .long 0

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

/* Fetch label ID and increment it */
_label_id:
	movl label_id, %eax
	incl label_id
	ret

_strlen_escape:
	xorl %eax, %eax /* length=0 */
	movl 4(%esp), %ebx /* string */
1:
	/* Fetching char from string */
	movb (%ebx), %cl
	/* If char is \0, breaking the loop */
	cmpb $0, %cl
	je 2f
	/* If escape code, skipping two chars */
	cmpb $'\\, %cl
	je 3f
	/* Incrementing length, doing next iteration */
	incl %ebx
	incl %eax
	jmp 1b
2:
	ret
3:
	incl %eax
	addl $2, %ebx
	jmp 1b

/* String buffer */
_push_string:
	subl $8, %esp
	movl 12(%esp), %eax /* string */
	movl %eax, (%esp) /* Passing it as argument to strlen */
	call _strlen_escape /* Get length of string with escapes */
	decl %eax /* Decrementing length because we remove last " char */
	addl %eax, strbuf_offset /* New string offset = old offset + string length */
	call strlen /* Get length of string without escapes */
	decl %eax /* Decrementing length because we remove last " char */
	addl strbuf_length, %eax /* New string buffer length */
	cmpl $STRBUFSZ, %eax /* If new length > buffer size, erroring */
	ja _string_literals
	movl strbuf_length, %ebx /* Old string buffer length */
	movl %eax, strbuf_length /* Storing new buffer length */
	movl $strbuf, %eax /* Storing base address to %eax */
	addl %ebx, %eax /* Calculating string offset */
	movl %eax, (%esp) /* Using it as dest in strcpy */
	movl 12(%esp), %eax /* string */
	incl %eax /* Incrementing to skip first " char */
	movl %eax, 4(%esp) /* Using it as src in strcpy */
	call strcpy /* Copying string */
	/* Removing last " char */
	movl strbuf_length, %eax
	addl $strbuf, %eax
	decl %eax
	movb $0, (%eax)
	addl $8, %esp
	ret
/* Return address to next string */
_get_string_address:
	subl $4, %esp
	movl $strbuf_text, (%esp) /* Base address is located at this label */
	call puts
	movb $'+, (%esp) /* We want to add offset */
	call putc
	/* Print next string offset */
	movl strbuf_offset, %eax
	movl %eax, (%esp)
	call putd
	addl $4, %esp
	ret
/* Put strings to compiled file */
_put_strings:
	subl $8, %esp /* str/char, offset */
	/* If buffer is empty, exitting */
	cmpl $0, strbuf_length
	je 2f
	/* String are in rodata segment */
	call enter_rodata_segment
	/* Printing base address label */
	movl $strbuf_text, (%esp)
	call puts
	movb $':, (%esp)
	call putc
	call newline
	movl $0, 4(%esp)
1:
	/* Checking if all buffer was printed. If so, exitting */
	movl 4(%esp), %eax
	cmpl %eax, strbuf_length
	je 2f
	movl 4(%esp), %eax /* string */
	addl $strbuf, %eax /* Getting address of the string */
	movl %eax, (%esp) /* passing string as argument */
	call strlen /* getting length of the string */
	addl %eax, 4(%esp) /* adding length to offset */
	/* Printing .string macro */
	call string
	/* Printing " */
	pushl %eax
	subl $1, %esp
	movb $'", (%esp)
	call putc
	addl $1, %esp
	popl %eax
	/* Printing string */
	call puts
	/* Printing " */
	pushl %eax
	subl $1, %esp
	movb $'", (%esp)
	call putc
	addl $1, %esp
	popl %eax
	call newline
	/* Making next iteration */
	incl 4(%esp)
	jmp 1b
2:
	addl $8, %esp
	ret

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
	/* We start at .text segment */
	call enter_text_segment
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
	/* After all, put string buffer */
	call _put_strings
	ret

/* Parse and compile expressions */
_expr:
	cmpw $TOKEN_IF, token_tag
	je _if_expr
	cmpw $TOKEN_WHILE, token_tag
	je _while_expr
	cmpw $TOKEN_ALLOCATE, token_tag
	je _allocate_expr
	cmpw $TOKEN_RETURN, token_tag
	je _return_expr
	cmpw $TOKEN_SYSCALL, token_tag
	je _syscall_expr
	cmpw $TOKEN_GLOBAL, token_tag
	je _global_expr
	cmpw $TOKEN_GOTO, token_tag
	je _goto_expr
	cmpw $TOKEN_LABEL, token_tag
	je _label_expr
	call _toplevel_expr
	ret

/* Parse and compile if expression */
_if_expr:
	subl $8, %esp /* zero, ID */
	/* Allocating label for branches */
	call _label_id
	movl %eax, 4(%esp)
	/* Checking 'if' expression correctness */
	call lex
	cmpw $'(, token_tag
	jne _syntax_error
	/* Parsing condition */
	call lex
	call _or_expr
	/* Checking 'if' expression correctness again */
	call lex
	cmpw $'), token_tag
	jne _syntax_error
	/* Compiling 'if' expression */
	call cmpl /* Comparing result to zero */
	movl $0, (%esp)
	call value
	call comma
	call eax
	call newline
	call je /* Jump if equal */
	movl 4(%esp), %eax /* Printing label_id */
	movl %eax, (%esp)
	call label
	call newline
	/* Parsing 'if' block */
	call _block
	/* Parsing 'else' expression. (If it is not there, we have to hold token) */
	call lex
	cmpw $TOKEN_ELSE, token_tag
	jne 1f
	/* Compiling 'else' expression */
	call jmp
	call _label_id
	movl %eax, (%esp)
	call label
	call newline
	/* Defining 'else' label */
	movl 4(%esp), %eax /* Exchanging 'if' label and 'else' label in stack */
	movl (%esp), %ebx
	movl %ebx, 4(%esp)
	movl %eax, (%esp)
	call label_def
	call newline
	/* Parsing 'else' block */
	call _block
	/* Ending 'if'/'else' expression */
	jmp 2f
1:
	/* Holding token, fetched when tried to parse 'else' */
	call lex_hold
2:
	/* Ending 'if' expression */
	movl 4(%esp), %eax
	movl %eax, (%esp)
	call label_def
	call newline
	addl $8, %esp
	ret

/* Parse and compile while expression */
_while_expr:
	subl $12, %esp /* zero/label_id, label_id1, label_id2 */
	/* Allocating two labels for loop */
	call _label_id
	movl %eax, 8(%esp)
	call _label_id
	movl %eax, 4(%esp)
	/* Start of loop (start of label_id1) */
	movl %eax, (%esp)
	call label_def
	call newline
	/* Checking 'while' expression correctness */
	call lex
	cmpw $'(, token_tag
	jne _syntax_error
	/* Parsing condition */
	call lex
	call _or_expr
	/* Checking 'while' expression correctness again */
	call lex
	cmpw $'), token_tag
	jne _syntax_error
	/* Compiling 'while' expression */
	call cmpl /* Comparing result to zero */
	movl $0, (%esp)
	call value
	call comma
	call eax
	call newline
	call je /* Jump if equal */
	movl 8(%esp), %eax /* Printing label_id */
	movl %eax, (%esp)
	call label
	call newline
	/* Parsing 'while' block */
	call _block
	/* Compiling 'while' expression end */
	call jmp
	movl 4(%esp), %eax
	movl %eax, (%esp)
	call label
	call newline
	/* End of 'while' label */
	movl 8(%esp), %eax
	movl %eax, (%esp)
	call label_def
	call newline
	addl $12, %esp
	ret

/* Parse and compile allocate expression */
_allocate_expr:
	/* Fetching next expression */
	call lex
	call _simple_expr
	/* Constructing imul instruction */
	call imul
	pushl $4
	call value
	addl $4, %esp
	call comma
	call eax
	call newline
	/* Constructing subl instruction */
	call subl
	call eax
	call comma
	call esp
	call newline
	ret

/* Parse and compile return expression */
_return_expr:
	/* Fetching next token */
	call lex
	/* If just semicolon, exitting */
	cmpw $';, token_tag
	je 1f
	/* Returning value */
	call _or_expr
	call leave
	call newline
	call ret
	call newline
	ret
1:
	/* Holding token */
	call lex_hold
	call leave
	call newline
	call ret
	call newline
	ret

/* Parse and compile syscall expression */
_syscall_expr:
	subl $4, %esp /* interrupt number */
	/* Backing up some registers */
	call pushl_esi
	call pushl_edi
	call pushl_ebp
	/* Parsing syscall arguments */
	call lex
	call _function_call_args
	/* In %eax number of args stored. Depending on count, loading needed regs */
	cmpl $7, %eax
	je 1f
	cmpl $6, %eax
	je 2f
	cmpl $5, %eax
	je 3f
	cmpl $4, %eax
	je 4f
	cmpl $3, %eax
	je 5f
	cmpl $2, %eax
	je 6f
	jmp 7f
1:
	call popl_ebp
2:
	call popl_edi
3:
	call popl_esi
4:
	call popl_edx
5:
	call popl_ecx
6:
	call popl_ebx
7:
	call popl_eax
	/* Constructing 'int $0x80' */
	call int
	movl $0x80, (%esp)
	call value
	call newline
	/* Restoring registers */
	call popl_ebp
	call popl_edi
	call popl_esi
	addl $4, %esp
	ret

/* Parse and compile global expression */
_global_expr:
	/* Parsing in .global macro */
	call global
	/* Fetching next token */
	call lex
	/* Checking if token is (. If not, trying to compile one export */
	cmpw $'(, token_tag
	jne 1f
	/* Parsing identifier list */
	subl $4, %esp /* char/text */
	/* Fetching next token */
	call lex
2:
	/* Checking if token is identifier. If not, erroring */
	cmpw $TOKEN_IDENTIFIER, token_tag
	jne _syntax_error
	movl $token_text, (%esp) /* Printing identifier name */
	call puts
	/* Fetching next token */
	call lex
	/* Checking if token is ,. If not, trying to exit. */
	cmpw $',, token_tag
	jne 2f
	/* Printing , char */
	movb $',, (%esp)
	call putc
	/* Fetching next char and making next iteration */
	call lex
	jmp 2b
2:
	/* Checking if token is ). If not, erroring */
	cmpw $'), token_tag
	jne _syntax_error
	call newline
	addl $4, %esp
	ret
1:
	/* Checking if token is identifier. If not, erroring */
	cmpw $TOKEN_IDENTIFIER, token_tag
	jne _syntax_error
	pushl $token_text
	call puts
	addl $4, %esp
	call newline
	ret

/* Parse and compile 'goto' expression */
_goto_expr:
	/* Fetching next token and expression */
	call lex
	call _or_expr
	/* Compiling jump */
	call jmp
	pushl $'*
	call putc
	addl $4, %esp
	call eax
	call newline
	ret

/* Parse and compile 'label' expression */
_label_expr:
	/* Fetching next token */
	call lex
	/* Checking if token is identifier. If not, erroring */
	cmpw $TOKEN_IDENTIFIER, token_tag
	jne _syntax_error
	/* Creating label */
	pushl $token_text
	call puts
	movb $':, (%esp)
	call putc
	call newline
	addl $4, %esp
	ret

/* Parse and compile block */
_block:
	/* Fetching next token */
	call lex
	/* Checking if token is {. If not, erroring */
	cmpw $'{, token_tag
	jne _syntax_error
	/* Fetching next token */
	call lex
1:
	/* If token is ;, we should skip it. */
	cmpw $';, token_tag
	jne 2f
	/* Fetching new token, and trying again */
	call lex
	jmp 1b
2:
	/* If token is }, exitting */
	cmpw $'}, token_tag
	je 1f
	/* Parsing and compiling expression */
	call _expr
	/* Fetching next token */
	call lex
	/* If token is not ;, and not }, it's syntax error. Trying to exit */
	cmpw $';, token_tag
	jne 1f
	/* Fetching next token and iterating again */
	call lex
	jmp 1b
1:
	/* Trying to exit. Checking if token is }. If not, erroring */
	cmpw $'}, token_tag
	jne _syntax_error
	ret

/* Parse and compile top-level expressions */
_toplevel_expr:
	cmpw $TOKEN_IDENTIFIER, token_tag
	je 1f
	cmpw $TOKEN_ARGUMENT, token_tag
	je 4f
	cmpw $TOKEN_VARIABLE, token_tag
	je 5f
	call _simple_expr
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
	je _function_call
	cmpw $'[, token_tag
	je 2f
	cmpw $'=, token_tag
	je 3f
	/* If none of above listed, erroring */
	call _syntax_error
2:
	/* Parse identifier indexing */
	subl $4, %esp /* int/char/zero */
	/* Fetching expression in 'index' */
	call lex
	call _or_expr
	call pushl_eax
	/* Checking if it is correct expression */
	call lex
	cmpw $'], token_tag
	jne _syntax_error
	call lex
	cmpw $'=, token_tag
	jne _syntax_error
	/* Parsing value to set */
	call lex
	call _or_expr /* Value stored in %eax */
	/* Storing index in %ebx */
	call popl_ebx
	/* Loading from identifier address + offset to %eax */
	call movl
	call eax
	call comma
	movl $0, (%esp)
	call _get_ident
	movl %eax, (%esp)
	call puts
	call _pop_ident
	movb $'(, (%esp)
	call putc
	call comma
	call ebx
	call comma
	movl $4, (%esp)
	call putd
	movb $'), (%esp)
	call putc
	call newline
	addl $4, %esp
	ret
3:
	/* Parse identifier assigning */
	/* Fetching value which we assign to */
	call lex
	call _or_expr
	/* Compiling */
	call movl
	call eax
	call comma
	pushl $0
	call _get_ident
	movl %eax, (%esp)
	call puts
	addl $4, %esp
	call _pop_ident
	call newline
	ret
4:
	/* TODO: implement argument parsing */
5:
	/* TODO: implement varibale parsing */
6:
	/* Exit point of _toplevel_expr */
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
	call _pop_ident /* Removing identifier from stack */
	/* Appending colon symbol */
	movb $':, (%esp)
	call putc
	addl $4, %esp
	call newline
	/* Parsing function arguments */
	call _function_args
	/* Initializing stack pointer */
	call enter_stack
	/* Parse function content */
	call _block
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

/* Parse and compile address call */
_address_call:
	subl $8, %esp /* arg, args_count */
	call pushl_eax
	movl $0, 4(%esp) /* args_count */
	call _function_call_args
	movl %eax, 4(%esp) /* Store number of arguments */
	cmpl $0, %eax
	je 1f
	movl %eax, (%esp)
	call _function_call_push_args
1:
	call movl
	/* Calculating offset in stack */
	movl 4(%esp), %eax
	imul $8, %eax
	movl %eax, (%esp)
	call putd
	/* Stack addressing */
	movb $'(, (%esp)
	call putc
	call esp
	movb $'), (%esp)
	call putc
	call comma
	call eax
	call newline
	/* Calling address */
	movl $'*, (%esp)
	call putc
	call eax
	call newline
	/* If args_count != 0, fixing% esp */
	movl 4(%esp), %eax
	cmpl $0, %eax
	je 1f
	/* Fixing stack pointer */
	call addl
	movl 4(%esp), %eax
	imul $8, %eax
	addl $4, %eax
	movl %eax, (%esp)
	call value
	call comma
	call esp
	call newline
1:
	addl $8, %esp
	ret

/* Parse and compile function call */
_function_call:
	subl $8, %esp
	call _function_call_args
	movl %eax, 4(%esp) /* saving number of arguments */
	/* If no arguments passed, go to function calling */
	cmpl $0, %eax
	je 1f
	movl %eax, (%esp)
	call _function_call_push_args
1:
	/* Printing call instruction */
	call call
	movl $0, (%esp)
	call _get_ident /* Fetching identifier */
	movl %eax, (%esp)
	call puts /* Printing identifier */
	call _pop_ident /* Removing identifier from stack */
	call newline
	/* If no arguments passed, exiting */
	cmpl $0, 4(%esp)
	je 2f
	/* As we passed arguments, we must fix stack */
	call addl
	movl 4(%esp), %eax /* loading number of arguments */
	imul $8, %eax
	movl %eax, (%esp)
	/* Finishing instruction */
	call value
	call comma
	call esp
	call newline
2:
	addl $8, %esp
	ret

/* Parse function call arguments */
_function_call_args:
	subl $4, %esp   /* number of args */
	movl $0, (%esp) /* count=0 */
	/* Checking if current token is (. If not, _syntax_error */
	cmpw $'(, token_tag
	jne _syntax_error
	/* Fetching next token */
	call lex
	/* Checking if current token is ). If so, exitting. */
	cmpw $'), token_tag
	je 2f
1:
	/* Parsing argument */
	incl (%esp) /* Incrementing counter */
	call _or_expr /* Parsing expression in it */
	call pushl_eax /* Pushing result of expression to stack */
	/* Checking if next token is ,. If not, trying to exit. */
	call lex
	cmpw $',, token_tag
	jne 2f
	/* Making next iteration */
	call lex
	jmp 1b
2:
	/* If function call is not ended with ), erroring */
	cmpw $'), token_tag
	jne _syntax_error
	movl (%esp), %eax
	addl $4, %esp
	ret

/* Push function call arguments to stack */
_function_call_push_args:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp /* arg, counter */

	/* Allocate stack frame */
	call subl
	movl 8(%ebp), %eax
	imul $4, %eax
	movl %eax, (%esp) /* Amount of bytes to allocate */
	call value
	call comma
	call esp
	call newline
	/* Copying arguments */
	movl $0, -4(%ebp) /* counter=0 */
1:
	/* Checking if counter == number of argument. If so, exitting */
	movl 8(%ebp), %eax
	movl -4(%ebp), %ebx
	cmpl %eax, %ebx
	je 1f
	/* Constructing instructions */
	call movl
	/* Calculating offset in stack */
	movl 8(%ebp), %eax
	imul $2, %eax
	movl -4(%ebp), %ebx
	subl %ebx, %eax
	decl %eax
	imul $4, %eax
	movl %eax, (%esp)
	call putd
	/* Stack addressing */
	movb $'(, (%esp)
	call putc
	call esp
	movb $'), (%esp)
	call putc
	call comma
	call eax
	call newline
	/* Storing argument in new place */
	call movl
	call eax
	call comma
	/* Calculating offset in stack */
	movl -4(%ebp), %eax
	imul $4, %eax
	movl %eax, (%esp)
	call putd
	/* Stack addressing */
	movb $'(, (%esp)
	call putc
	call esp
	movb $'), (%esp)
	call putc
	call newline
	/* Making next iteration */
	incl -4(%ebp)
	jmp 1b
1:
	leave
	ret

/* Try to parse '|' (or) expression. */
_or_expr:
	/* Fetching first operand */
	call _xor_expr
1:
	/* Trying to parse '|' (or) expression */
	call lex /* Fetching next token */
	cmpw $'|, token_tag /* If token is not '|', exitting */
	jne 1f
	/* Contructing 'orl' instruction */
	call pushl_eax /* Backing up first operand */
	call lex /* Fetching next token */
	call _xor_expr /* Fetching second operand in %eax */
	call popl_ebx /* Loading first operand in %ebx */
	call orl
	call ebx
	call comma
	call eax
	call newline
	/* Trying to parse '|' (or) expression again */
	jmp 1b
1:
	call lex_hold
	ret

/* Try to parse '^' (xor) expression. */
_xor_expr:
	/* Fetching first operand */
	call _and_expr
1:
	/* Trying to parse '^' (xor) expression */
	call lex /* Fetching next token */
	cmpw $'^, token_tag /* If token is not '^', exitting */
	jne 1f
	/* Contructing 'xorl' instruction */
	call pushl_eax /* Backing up first operand */
	call lex /* Fetching next token */
	call _and_expr /* Fetching second operand in %eax */
	call popl_ebx /* Loading first operand in %ebx */
	call xorl
	call ebx
	call comma
	call eax
	call newline
	/* Trying to parse '^' (xor) expression again */
	jmp 1b
1:
	call lex_hold
	ret

/* Try to parse '&' (and) expression. */
_and_expr:
	/* Fetching first operand */
	call _equal_expr
1:
	/* Trying to parse '&' (and) expression */
	call lex /* Fetching next token */
	cmpw $'&, token_tag /* If token is not '&', exitting */
	jne 1f
	/* Contructing 'andl' instruction */
	call pushl_eax /* Backing up first operand */
	call lex /* Fetching next token */
	call _equal_expr /* Fetching second operand in %eax */
	call popl_ebx /* Loading first operand in %ebx */
	call andl
	call ebx
	call comma
	call eax
	call newline
	/* Trying to parse '&' (and) expression again */
	jmp 1b
1:
	call lex_hold
	ret

/* Try to parse '==' and '!=' expressions. */
_equal_expr:
	/* Fetching first operand */
	call _compare_expr
1:
	/* Checking if token is '==' or '!='. If not, exitting */
	call lex
	cmpw $TOKEN_EQUAL, token_tag
	je 2f
	cmpw $TOKEN_NOTEQUAL, token_tag
	je 2f
	/* Exitting */
	call lex_hold
	ret
2:
	subl $2, %esp /* op_type */
	movw token_tag, %ax
	movw %ax, (%esp)
	/* Parsing expression */
	call pushl_eax /* Backing up first operand */
	call lex /* Fetching next token */
	call _compare_expr /* Fetching second operand in %eax */
	call movl /* Loading second operand in %ebx */
	call eax
	call comma
	call ebx
	call newline
	call popl_eax /* Restoring first operand */
	call cmpl /* Comparing operands */
	call eax
	call comma
	call ebx
	call newline
	/* If op is '==', setting equal flag. Otherwise (!=), not equal flag. */
	cmpw $TOKEN_NOTEQUAL, (%esp)
	je 2f
	call sete /* Setting equal flag */
	jmp 3f
2:
	call setne /* Setting not equal flag */
3:
	addl $2, %esp /* We don't need op_type now */
	call al /* Setting flag in %al */
	call newline
	call movzbl /* Move %al to %eax with zeroing */
	call al
	call comma
	call eax
	call newline
	/* Trying to parse '==' or '!=' expressions again */
	jmp 1b
	ret

/* Try to parse '<', '>', '<=', '>=' expressions. */
_compare_expr:
	/* NOTE: comparisons are signed. To add unsigned, we need to use more set*
	 * instructions, what is not efficient in Assembler implementation. In
	 * bootstrapped version I guess I will add unsigned comparison */
	/* Fetching first operand */
	call _add_sub_expr
1:
	/* Checking if token is '<', '>', '<=' or '>='. If not, exitting */
	call lex
	cmpw $'<, token_tag
	je 2f
	cmpw $'>, token_tag
	je 2f
	cmpw $TOKEN_LE, token_tag
	je 2f
	cmpw $TOKEN_GE, token_tag
	je 2f
	/* Exitting */
	call lex_hold
	ret
2:
	subl $2, %esp /* op_type */
	movw token_tag, %ax
	movw %ax, (%esp)
	/* Parsing expression */
	call pushl_eax /* Backing up first operand */
	call lex /* Fetching next token */
	call _add_sub_expr /* Fetching second operand in %eax */
	call movl /* Loading second operand in %ebx */
	call eax
	call comma
	call ebx
	call newline
	call popl_eax /* Restoring first operand */
	call cmpl /* Comparing operands */
	call eax
	call comma
	call ebx
	call newline
	/* If op is '<', setting less flag. */
	/* If op is '>', setting greater flag. */
	/* If op is '<=', setting less or equal flag. */
	/* If op is '>=', setting greater or equal flag. */
	cmpw $'<, (%esp)
	je 2f
	cmpw $'>, (%esp)
	je 3f
	cmpw $TOKEN_LE, (%esp)
	je 4f
	call setge /* Setting greater or equal flag */
	jmp 5f
2:
	call setl /* Setting less flag */
	jmp 5f
3:
	call setg /* Setting greater flag */
	jmp 5f
4:
	call setle /* Setting less or equal flag */
5:
	addl $2, %esp /* We don't need op_type now */
	call al /* Setting flag in %al */
	call newline
	call movzbl /* Move %al to %eax with zeroing */
	call al
	call comma
	call eax
	call newline
	/* Trying to parse '<', '>', '<=' or '>=' expressions again */
	jmp 1b
	ret

/* Try to parse '+', '-' expressions. */
_add_sub_expr:
	/* Fetching first operand */
	call _mul_div_mod_expr
1:
	/* Checking if token is '+' or '-'. If not, exitting */
	call lex
	cmpw $'+, token_tag
	je 2f
	cmpw $'-, token_tag
	je 3f
	/* Exitting */
	call lex_hold
	ret
2:
	/* Parsing '+' expression */
	call pushl_eax /* Backing up first operand */
	call lex /* Fetching next token */
	call _mul_div_mod_expr /* Fetching second operand in %eax */
	call popl_ebx /* Loading first operand in %ebx */
	call addl
	call ebx
	call comma
	call eax
	call newline
	/* Trying to parse '+' or '-' expressions again */
	jmp 1b
3:
	/* Parsing '-' expression */
	call pushl_eax /* Backing up first operand */
	call lex /* Fetching next token */
	call _mul_div_mod_expr /* Fetching second operand in %eax */
	call movl /* Loading second operand in %ebx */
	call eax
	call comma
	call ebx
	call newline
	call popl_eax /* Loading first operand in %eax */
	call subl
	call ebx
	call comma
	call eax
	call newline
	/* Trying to parse '+' or '-' expressions again */
	jmp 1b

/* Try to parse '*', '/', '%' expressions. */
_mul_div_mod_expr:
	/* NOTE: for now, there is only integer division */
	/* Fetching first operand */
	call _prefix_expr
1:
	/* Checking if token is '*', '/' or '%'. If not, exitting */
	call lex
	cmpw $'*, token_tag
	je 2f
	cmpw $'/, token_tag
	je 3f
	cmpw $'%, token_tag
	je 3f
	/* Exitting */
	call lex_hold
	ret
2:
	/* Parsing '*' expression */
	call pushl_eax /* Backing up first operand */
	call lex /* Fetching next token */
	call _prefix_expr /* Fetching second operand in %eax */
	call popl_ebx /* Loading first operand in %ebx */
	call imul
	call ebx
	call comma
	call eax
	call newline
	/* Trying to parse '*', '/' or '%' expressions again */
	jmp 1b
3:
	subl $2, %esp /* op_code */
	movw token_tag, %ax
	movw %ax, (%esp)
	/* Parsing '/' or '%' expression */
	call pushl_eax /* Backing up first operand */
	call lex /* Fetching next token */
	call _prefix_expr /* Fetching second operand in %eax */
	call movl /* Loading second operand in %ebx */
	call eax
	call comma
	call ebx
	call newline
	call popl_eax /* Loading first operand in %eax */
	call xorl /* Zeroing %edx */
	call edx
	call comma
	call edx
	call newline
	call idiv /* Making division */
	call ebx
	call newline
	/* If op was '/', skipping storing modulus in %eax */
	cmpw $'/, (%esp)
	je 3f
	/* Storing modulus in %eax */
	call movl
	call edx
	call comma
	call eax
	call newline
3:
	addl $2, %esp /* op_code is not needed anymore */
	/* Trying to parse '*', '/' or '%' expressions again */
	jmp 1b

/* Try to parse '+', '-', '~', '*', '&' prefix expressions. */
_prefix_expr:
	cmpw $'+, token_tag
	je 1f
	cmpw $'-, token_tag
	je 2f
	cmpw $'~, token_tag
	je 3f
	cmpw $'*, token_tag
	je 4f
	cmpw $'&, token_tag
	je 5f
	/* Using _simple_expr if no prefix found */
	call _simple_expr
	ret
1:
	/* Parsing '+' prefix by simply skipping it */
	call lex
	call _simple_expr
	ret
2:
	/* Parsing '-' prefix */
	call lex
	call _simple_expr
	/* 'negl' on %eax */
	call negl
	call eax
	call newline
	ret
3:
	/* Parsing '~' prefix */
	call lex
	call _simple_expr
	/* 'notl' on %eax */
	call notl
	call eax
	call newline
	ret
4:
	/* Parsing '*' (dereferencing) prefix */
	subl $1, %esp /* char */
	call lex
	call _simple_expr /* Parsing expression to dereference */
	/* Constructing instruction */
	call movl
	movb $'(, (%esp)
	call putc
	call eax
	movb $'), (%esp)
	call putc
	call comma
	call eax
	call newline
	addl $1, %esp
	ret
5:
	/* Parsing '&' (addressof) prefix */
	/* If next token is not identifier, argument or variable, erroring */
	call lex
	cmpw $TOKEN_IDENTIFIER, token_tag
	je 1f
	cmpw $TOKEN_ARGUMENT, token_tag
	je 2f
	cmpw $TOKEN_VARIABLE, token_tag
	jne _syntax_error
	jmp 3f
1:
	/* Parsing addressof identifier */
	subl $4, %esp /* char/str */
	call movl
	movb $'$, (%esp)
	call putc
	movl $token_text, (%esp)
	call puts
	call comma
	call eax
	call newline
	addl $4, %esp
	ret
2:
	/* Parsing addressof argument */
	call movl /* Loading current stack offset value in %eax */
	call ebp
	call comma
	call eax
	call newline
	call addl /* Adding to offset to get argument address */
	movl token_val, %eax
	addl $2, %eax
	imul $4, %eax /* Offset of argument */
	pushl %eax
	call value
	addl $4, %esp
	call comma
	call eax
	call newline
	ret
3:
	/* Parsing addressof variable */
	call movl /* Loading current stack offset value in %eax */
	call ebp
	call comma
	call eax
	call newline
	call subl /* Subtracting to offset to get argument address */
	movl token_val, %eax
	incl %eax
	imul $4, %eax /* Offset of argument */
	pushl %eax
	call value
	addl $4, %esp
	call comma
	call eax
	call newline
	ret

/* Parse and compile expressions that return some result */
_simple_expr:
	cmpw $TOKEN_IDENTIFIER, token_tag
	je 1f
	cmpw $TOKEN_ARGUMENT, token_tag
	je _return_argument
	cmpw $TOKEN_VARIABLE, token_tag
	je _return_variable
	cmpw $TOKEN_SYSCALL, token_tag
	je _syscall_expr
	cmpw $'(, token_tag
	je _parse_parantheses
	call _constant_expr
	jmp 2f
1:
	pushl $token_text
	call _push_ident /* Pushing identifier to stack */
	addl $4, %esp
	/* Checking, what is the next character */
	call lex
	cmpw $'(, token_tag
	je _function_call
	cmpw $'[, token_tag
	je _return_array_value
	/* If none of above listed, reading value from label */
	jmp _return_label_value
2:
	/* Exit point of _simple_expr */
	ret

_return_label_value:
	/* Reading value from label */
	call movl
	pushl $0
	call _get_ident
	movl %eax, (%esp)
	call puts
	addl $4, %esp
	call _pop_ident
	call comma
	call eax
	call newline
	jmp 2b

_return_array_value:
	/* Parse identifier indexing */
	subl $4, %esp /* int/char/zero */
	/* Fetching expression in 'index' */
	call lex
	call _or_expr
	call pushl_eax
	/* Checking if it is correct expression */
	call lex
	cmpw $'], token_tag
	jne _syntax_error
	/* Storing index in %ebx */
	call popl_ebx
	/* Loading from identifier address + offset to %eax */
	call movl
	movl $0, (%esp)
	call _get_ident
	movl %eax, (%esp)
	call puts
	call _pop_ident
	movb $'(, (%esp)
	call putc
	call comma
	call ebx
	call comma
	movl $4, (%esp)
	call putd
	movb $'), (%esp)
	call putc
	call comma
	call eax
	call newline
	addl $4, %esp
	ret

/* Parse and compile argument */
_return_argument:
	/* Constructing `movl` instruction */
	call movl
	pushl token_val
	call argument
	addl $4, %esp
	call comma
	call eax
	call newline
	jmp 2b

/* Parse and compile variable */
_return_variable:
	/* Constructing `movl` instruction */
	call movl
	pushl token_val
	call variable
	addl $4, %esp
	call comma
	call eax
	call newline
	jmp 2b

/* Parse parantheses */
_parse_parantheses:
	/* Fetching next token */
	call lex
	/* Fetching next expression */
	call _or_expr
	/* Fetching next token */
	call lex
	/* Checking if token is ). If not, erroring */
	cmpw $'), token_tag
	jne _syntax_error
	jmp 2b

/* Parse and compile consant expressions */
_constant_expr:
	cmpw $TOKEN_INTEGER, token_tag
	je _constant_expr_integer
	cmpw $TOKEN_STRING, token_tag
	je _constant_expr_string
	/* If nothing was parsed, syntax erroring */
	jmp _syntax_error

_constant_expr_integer:
	/* Storing integer value to %eax */
	call movl /* Printing movl instruction */
	pushl token_val
	call value /* Printing token_val */
	addl $4, %esp
	call comma
	call eax
	call newline
	ret

_constant_expr_string:
	/* Storing string address to %eax */
	subl $1, %esp /* char */
	call movl /* Printing movl instruction */
	movb $'$, (%esp)
	call putc /* Printing dollar sign */
	addl $1, %esp
	call _get_string_address /* Print string address */
	call comma
	call eax
	call newline
	/* Store new string in buffer */
	pushl $token_text
	call _push_string
	addl $4, %esp
	ret
