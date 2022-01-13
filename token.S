/* Codes of single-char tokens are their ASCII codes */
.equ TOKEN_INTEGER,    256
.equ TOKEN_STRING,     257
.equ TOKEN_IDENTIFIER, 258
.equ TOKEN_ARGUMENT,   259 /* argument (a-var) */
.equ TOKEN_VARIABLE,   260 /* local variable (x-var) */
/* Conditionals */
.equ TOKEN_IF,         261
.equ TOKEN_ELSE,       262
/* Loops */
.equ TOKEN_WHILE,      263
/* Functions */
.equ TOKEN_ALLOCATE,   264
.equ TOKEN_RETURN,     265
.equ TOKEN_SYSCALL,    266
/* Labels */
.equ TOKEN_GLOBAL,     267
.equ TOKEN_GOTO,       268
.equ TOKEN_LABEL,      269
/* Symbols */
.equ TOKEN_EQUAL,      270 /* == */
.equ TOKEN_NOTEQUAL,   271 /* != */
.equ TOKEN_LE,         272 /* <= */
.equ TOKEN_GE,         273 /* >= */
/* End of token */
.equ TOKEN_END,        274

/* Maximum token size */
.equ MAX_TOKEN_LEN, 128 /* NOTE: in future may be changed */
