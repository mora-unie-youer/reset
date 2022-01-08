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


.data
.equ MAX_TOKEN_LEN, 64 /* NOTE: in future may be changed */

.comm token_text, MAX_TOKEN_LEN, 1
.global token_tag, token_len, token_val
token_tag: .byte 0
token_len: .long 0
token_val: .long 0

.global line
line: .long 1


.text
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
	/* TODO: error printing */

_skip:
	/* Fetching char */
	call getc
	/* If newline, incrementing counter */
	cmpb $'\n, %al
	jne 1f
	incl line
1:
	ret

.global lex
lex:
	pushl %ebp
	movl %esp, %ebp
	leave
	ret
