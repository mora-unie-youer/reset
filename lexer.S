.section .rodata

/* Character types */
.equ CHAR_NULL    0 /* \0 */
.equ CHAR_INVALID 1 /* invalid characters */
.equ CHAR_SPACES  2 /* [\t\r ] */
.equ CHAR_NEWLINE 3 /* \n */
.equ CHAR_NUMBER  4 /* [0-9] */
.equ CHAR_ALPHA   5 /* [A-Za-z_] */
.equ CHAR_A_OR_X  6 /* a|x */
.equ CHAR_SQUOTE  7 /* \' */
.equ CHAR_DQUOTE  8 /* \" */
.equ CHAR_SYMBOL  9 /* other characters */

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
	.byte  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1

