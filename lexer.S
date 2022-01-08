.include "token.S"

.section .rodata

/* Character types */
.equ CHAR_NULL,    0 /* \0 */
.equ CHAR_INVALID, 1 /* invalid characters */
.equ CHAR_SPACES,  2 /* [\t\r ] */
.equ CHAR_NEWLINE, 3 /* \n */
.equ CHAR_NUMBER,  4 /* [0-9] */
.equ CHAR_ALPHA,   5 /* [A-Za-z_] */
.equ CHAR_A_OR_X,  6 /* a|x */
.equ CHAR_SQUOTE,  7 /* \' */
.equ CHAR_DQUOTE,  8 /* \" */
.equ CHAR_SYMBOL,  9 /* other characters */

/* Char table for easier char type guessing */
char_table:
	/*    x0  x1  x2  x3  x4  x5  x6  x7  x8  x9  xA  xB  xC  xD  xE  xF */
	.byte  0,  1,  1,  1,  1,  1,  1,  1,  1,  2,  3,  1,  1,  2,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  2,  9,  8,  9,  9,  9,  9,  7,  9,  9,  9,  9,  9,  9,  9,  9
	.byte  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  9,  9,  9,  9,  9,  9
	.byte  9,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5
	.byte  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  9,  9,  9,  9,  5
	.byte  9,  6,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5
	.byte  5,  5,  5,  5,  5,  5,  5,  5,  6,  5,  5,  9,  9,  9,  9,  1
	/* E-ASCII is always invalid for us */
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0 /*EOF*/

reserved_words:
	/* Conditionals */
	.long if_text, else_text
	/* Loops */
	.long while_text
	/* Functions */
	.long allocate_text, return_text, syscall_text

if_text:       .string "if"
else_text:     .string "else"
while_text:    .string "while"
allocate_text: .string "allocate"
return_text:   .string "return"
syscall_text:  .string "syscall"

/* Messages */
line_string: .string "line "
error_string: .string ": ERROR: "
/* Error messages */
too_long_token_string: .string "Too long token\n"
undefined_token_string: .string "Undefined token\n"

.data
.equ MAX_TOKEN_LEN, 64 /* NOTE: in future may be changed */

.comm token_text, MAX_TOKEN_LEN, 1
.global token_tag, token_len, token_val
token_tag: .short 0
token_len: .long 0
token_val: .long 0

.global line
line: .long 1


.text
/* Print line */
_print_line:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp /* string/line_number */
	/* Printing line_string */
	movl $line_string, -4(%ebp)
	call puts
	/* Printing line number */
	movl line, %ebx
	movl %ebx, -4(%ebp)
	call putd
	leave
	ret

/* Print error and exit */
_print_error:
	pushl %ebp
	movl %esp, %ebp
	call flush /* Print all the output */
	call _print_line /* Printing line number */
	movl $error_string, (%ebp) /* error string */
	call puts /* Printing error string */
	movl 8(%ebp), %ebx /* error message */
	movl %ebx, (%ebp) /* passing message as argument */
	call puts /* Printing error message */
	movl $2, output_fd /* Writing error to `stderr` */
	call flush /* Print to stderr */
	/* As error occured, exitting */
	pushl $1
	call exit

/* Errors (they are not returning, so no reason writing `ret`) */
_too_long_token:
	pushl $too_long_token_string
	call _print_error
_undefined_token:
	pushl $undefined_token_string
	call _print_error

/* Get type of next char */
_lookahead:
	/* NOTE: 0xff char and EOF are acting like the same */
	/* Zeroing %eax to use it as offset */
	xorl %eax, %eax
	/* Fetiching next char */
	call nextc
	/* Finding its type using table */
	movb char_table(%eax), %al
	ret

_consume:
	/* Fetching char */
	call getc
	/* If char is newline, increment counter */
	cmpb $'\n, %al
	jne 1f
	incl line
1:
	/* Getting token length */
	movl token_len, %ebx
	/* If >= max size, then printing error */
	cmpl $MAX_TOKEN_LEN-1, %ebx
	jae 2f
	movb %al, token_text(%ebx) /* Appending char to token text */
	addl $1, %ebx              /* Incrementing length */
	movb $0, token_text(%ebx)  /* Ending string with \0 */
	movl %ebx, token_len       /* Setting new token length */
	ret
2:
	/* Printing error and skipping */
	call _too_long_token

_skip:
	/* Fetching char */
	call getc
	/* If newline, incrementing counter */
	cmpb $'\n, %al
	jne 1f
	incl line
1:
	ret

/* Tables to manage which subroutine for which char type we should use */
/* The order is as char type order (see CHAR_NULL and etc.) */
s0_next: .long  s1,  s3,  s4,  s4,  s5,  s6,  s3,  s3,  s3,  s3
s5_next: .long  s2,  s2,  s2,  s3,  s5,  s3,  s3,  s3,  s3,  s2
s6_next: .long  s7,  s3,  s7,  s7,  s6,  s6,  s6,  s3,  s3,  s7

.global lex
lex:
	pushl %ebp
	movl %esp, %ebp
/* Entry point of lexer */
s0:
	movl $0, token_len
	movl $0, token_val
	call _lookahead
	movl s0_next(,%eax,4), %eax
	jmp *%eax
s1:
	/* Setting end of tokens */
	movw $TOKEN_END, token_tag
s2:
	/* Ending parsing */
	leave
	ret
s3:
	/* Throwing exception of undefined token */
	call _undefined_token
s4:
	/* Skipping this character */
	call _consume
	jmp s0
s5:
	/* Parsing digit */
	movw $TOKEN_INTEGER, token_tag
	call _consume
	subl $'0, %eax       /* Converting to value */
	movl token_val, %ebx /* Loading value */
	imul $10, %ebx
	addl %ebx, %eax      /* Adding digit to number */
	movl %eax, token_val /* Setting value */
	call _lookahead
	movl s5_next(,%eax,4), %eax
	jmp *%eax
s6:
	/* Parsing letter and underscore (and numbers, after first char is alpha) */
	movw $TOKEN_IDENTIFIER, token_tag
	call _consume   /* Adding letter/underscore/number to token_text */
	call _lookahead
	movl s6_next(,%eax,4), %eax
	jmp *%eax
s7:
	/* TODO: check for reserved keywords */
	jmp s2
