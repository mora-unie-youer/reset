.include "token.S"

.section .rodata

/* Character types */
.equ CHAR_NULL,      0  /* \0 */
.equ CHAR_INVALID,   1  /* invalid characters */
.equ CHAR_SPACES,    2  /* [\t\r ] */
.equ CHAR_NEWLINE,   3  /* \n */
.equ CHAR_NUMBER,    4  /* [0-9] */
.equ CHAR_ALPHA,     5  /* [A-Za-z_] */
.equ CHAR_A_OR_X,    6  /* a|x */
.equ CHAR_SQUOTE,    7  /* \' */
.equ CHAR_DQUOTE,    8  /* \" */
.equ CHAR_BACKSLASH, 9  /* \\ */
.equ CHAR_SYMBOL,    10 /* other characters */

/* Char table for easier char type guessing */
char_table:
	/*    x0  x1  x2  x3  x4  x5  x6  x7  x8  x9  xA  xB  xC  xD  xE  xF */
	.byte  0,  1,  1,  1,  1,  1,  1,  1,  1,  2,  3,  1,  1,  2,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  2, 10,  8, 10, 10, 10, 10,  7, 10, 10, 10, 10, 10, 10, 10, 10
	.byte  4,  4,  4,  4,  4,  4,  4,  4,  4,  4, 10, 10, 10, 10, 10, 10
	.byte 10,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5
	.byte  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5, 10,  9, 10, 10,  5
	.byte 10,  6,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5
	.byte  5,  5,  5,  5,  5,  5,  5,  5,  6,  5,  5, 10, 10, 10, 10,  1
	/* E-ASCII is always invalid for us */
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0 /*EOF*/

char_to_escape:
	/*    x0  x1  x2  x3  x4  x5  x6  x7  x8  x9  xA  xB  xC  xD  xE  xF */
	.byte  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	.byte  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	.byte  0,  0, 34,  0,  0,  0,  0, 39,  0,  0,  0,  0,  0,  0,  0,  0
	.byte  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 63
	.byte  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	.byte  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 92,  0,  0,  0
	.byte  0,  7,  8,  0,  0, 27, 12,  0,  0,  0,  0,  0,  0,  0, 10,  0
	.byte  0,  0, 13,  0,  9,  0, 11,  0,  0,  0,  0,  0,  0,  0,  0,  0

reserved_words:
	/* Conditionals */
	.long if_text, else_text
	/* Loops */
	.long while_text
	/* Functions */
	.long allocate_text, return_text, syscall_text
	/* Labels */
	.long global_text, goto_text, label_text
	/* Byte operations */
	.long readchar_text, writechar_text
	/* Types */
	.long char_text, int_text
	/* End of list */
	.long 0

if_text:       .string "if"
else_text:     .string "else"
while_text:    .string "while"
allocate_text: .string "allocate"
return_text:   .string "return"
syscall_text:  .string "syscall"
global_text:   .string "global"
goto_text:     .string "goto"
label_text:    .string "label"
readchar_text: .string "readchar"
writechar_text:.string "writechar"
char_text:     .string "char"
int_text:      .string "int"

/* Messages */
line_string: .string "line "
error_string: .string ": ERROR: "
/* Error messages */
hold_error_string: .string "Trying to hold two or more tokens\n"
too_long_token_string: .string "Too long token\n"
undefined_token_string: .string "Undefined token\n"

.data
/* Token attributes */
.comm token_text, MAX_TOKEN_LEN, 1
.global token_tag, token_len, token_val
token_tag: .short 0
token_len: .long 0
token_val: .long 0

/* Current source line */
.global line
line: .long 1

/* Hold current token on `lex` calling */
hold: .byte 0

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
.global print_error
print_error:
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
_hold_error:
	pushl $hold_error_string
	call print_error
_too_long_token:
	pushl $too_long_token_string
	call print_error
_undefined_token:
	pushl $undefined_token_string
	call print_error

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

_skip_line:
	/* Fetching char */
	call getc
	/* If not newline, continue loop */
	cmpb $'\n, %al
	jne _skip_line
	incl line
	ret

/* Tables to manage which subroutine for which char type we should use */
/* The order is as char type order (see CHAR_NULL and etc.) */
s0_next:  .long  s1,  s3,  s4,  s4,  s5,  s6,  s8, s10, s15,  s3, s18
s5_next:  .long  s2,  s3,  s2,  s2,  s5,  s3,  s3,  s3,  s3,  s3,  s2
s6_next:  .long  s7,  s3,  s7,  s7,  s6,  s6,  s6,  s3,  s3,  s3,  s7
s8_next:  .long  s7,  s3,  s7,  s7,  s9,  s6,  s6,  s3,  s3,  s3,  s7
s9_next:  .long  s2,  s3,  s2,  s2,  s9,  s6,  s6,  s3,  s3,  s3,  s2
s10_next: .long  s3,  s3, s11, s11, s11, s11, s11, s11, s11, s13, s11
s13_next: .long  s3,  s3,  s3,  s3, s14, s14, s14, s14, s14, s14,  s3
s15_next: .long  s3,  s3, s15, s15, s15, s15, s15, s15, s16, s17, s15
s17_next: .long  s3,  s3,  s3,  s3, s15, s15, s15, s15, s15, s15,  s3

/* Hold current token on `lex` calling */
.global lex_hold
lex_hold:
	/* If already holding, erroring */
	cmpb $0, hold
	jne _hold_error
	/* Setting holding to 'true' */
	movb $1, hold
	ret

.global lex
lex:
	pushl %ebp
	movl %esp, %ebp
	/* Checking if we need to hold the token */
	cmpb $1, hold
	jne s0 /* Start lexing, if not */
	/* Unsetting `hold` and returning */
	movb $0, hold
	leave
	ret
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
	/* Checking if token is identifier, to check if it's macro */
	cmpw $TOKEN_IDENTIFIER, token_tag
	jne 1f
	/* If identifier's first char is capital, it's macro */
	movb token_text, %al
	cmpb $'Z, %al
	ja 1f
	movw $TOKEN_MACRO, token_tag
1:
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
	/* Checking if identifier is reserved keyword */
	subl $12, %esp /* str1, str2, counter */
	movl $token_text, -12(%ebp) /* First string */
	xorl %eax, %eax
	movl %eax, -4(%ebp)
1:
	/* Current index of reserved_words */
	movl -4(%ebp), %eax
	movl reserved_words(,%eax,4), %eax /* Getting reserved word */
	/* %eax == 0 (end of list), identifier is not a reserved word */
	cmpl $0, %eax
	je 1f
	/* Storing reserved word to argument */
	movl %eax, -8(%ebp)
	/* Comparing strings */
	call strcmp
	/* If equal -> breaking loop */
	cmpl $1, %eax
	je 2f
	/* Making next iteration */
	incl -4(%ebp)
	jmp 1b
1:
	addl $12, %esp /* removing local variables */
	movw $TOKEN_IDENTIFIER, token_tag /* for cases, when it was arg/var */
	jmp s2
2:
	movl -4(%ebp), %eax  /* restoring index */
	addl $TOKEN_IF, %eax /* TOKEN_IF is first reserved word */
	movl %eax, token_tag /* storing token type */
	addl $12, %esp /* removeing local variables */
	jmp s2
s8:
	/* Parsing `a|x` variables (or identifiers starting with a or x) */
	call _consume
	cmpb $'a, %al
	je 1f
	movw $TOKEN_VARIABLE, token_tag
	jmp 2f
1:
	movw $TOKEN_ARGUMENT, token_tag
2:
	movl $0, token_val
	call _lookahead
	movl s8_next(,%eax,4), %eax
	jmp *%eax
s9:
	/* Parsing `a[0-9]+|x[0-9]+` variables */
	call _consume
	subl $'0, %eax /* Converting to value */
	movl token_val, %ebx /* loading value */
	imul $10, %ebx
	addl %ebx, %eax      /* Adding digit to number */
	movl %eax, token_val /* Setting value */
	call _lookahead
	movl s9_next(,%eax,4), %eax
	jmp *%eax
s10:
	/* Parsing single quote */
	call _consume
	call _lookahead
	movl s10_next(,%eax,4), %eax
	jmp *%eax
s11:
	/* Parsing single quote content */
	call _consume
	movl %eax, token_val
	call _lookahead
	cmpl $CHAR_SQUOTE, %eax
	jne s3 /* if next char is not single quote -> incorrect syntax */
s12:
	/* Consume single quote and set token type */
	call _consume
	movw $TOKEN_INTEGER, token_tag /* the value is integer */
	jmp s2
s13:
	/* Parsing backslash in single quotes */
	call _consume
	call _lookahead
	movl s13_next(,%eax,4), %eax
	jmp *%eax
s14:
	/* Parsing escape code in single quotes */
	xorl %eax, %eax
	call _consume
	movb char_to_escape(%eax), %al /* convert char to escape code */
	movl %eax, token_val
	call _lookahead
	cmpl $CHAR_SQUOTE, %eax
	je s12 /* Finalizing single quote parsing */
	jmp s3 /* If not single quote -> incorrect syntax */
s15:
	/* Parsing double quotes */
	call _consume
	call _lookahead
	movl s15_next(,%eax,4), %eax
	jmp *%eax
s16:
	/* Ending string in double quotes */
	call _consume
	movw $TOKEN_STRING, token_tag /* the value is string */
	jmp s2
s17:
	/* Parsing backslash in double quotes */
	call _consume
	call _lookahead
	movl s17_next(,%eax,4), %eax
	jmp *%eax
s18:
	/* Parsing symbols */
	call _consume
	movw %ax, token_tag
	/* Checking for multiple-char symbols */
	cmpl $'=, %eax
	je 1f
	cmpl $'!, %eax
	je 2f
	cmpl $'<, %eax
	je 3f
	cmpl $'>, %eax
	je 4f
	/* Checking for comment */
	cmpl $'#, %eax
	je 5f
	/* If not a above-listed char -> success */
	jmp s2
1:
	call nextc
	cmpl $'=, %eax /* == */
	je 1f
	cmpl $'>, %eax /* => */
	jne s2 /* if not == or =>, return */

	call _consume
	movw $TOKEN_ARROW, token_tag
	jmp s2
1:
	call _consume
	movw $TOKEN_EQUAL, token_tag
	jmp s2
2:
	call nextc
	cmpl $'=, %eax
	jne s2 /* if not !=, return */
	call _consume
	movw $TOKEN_NOTEQUAL, token_tag
	jmp s2
3:
	call nextc
	cmpl $'=, %eax
	jne s2 /* if not <=, return */
	call _consume
	movw $TOKEN_LE, token_tag
	jmp s2
4:
	call nextc
	cmpl $'=, %eax
	jne s2 /* if not >=, return */
	call _consume
	movw $TOKEN_GE, token_tag
	jmp s2
5:
	/* When comment, skip this line, and start again */
	call _skip_line
	jmp s0
