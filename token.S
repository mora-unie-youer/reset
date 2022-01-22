/* Codes of single-char tokens are their ASCII codes */
.equ TOKEN_INTEGER,    256
.equ TOKEN_STRING,     257
.equ TOKEN_IDENTIFIER, 258
.equ TOKEN_MACRO,      259
.equ TOKEN_ARGUMENT,   260 /* argument (a-var) */
.equ TOKEN_VARIABLE,   261 /* local variable (x-var) */
/* Conditionals */
.equ TOKEN_IF,         262
.equ TOKEN_ELSE,       263
/* Loops */
.equ TOKEN_WHILE,      264
/* Functions */
.equ TOKEN_ALLOCATE,   265
.equ TOKEN_RETURN,     266
.equ TOKEN_SYSCALL,    267
/* Labels */
.equ TOKEN_GLOBAL,     268
.equ TOKEN_GOTO,       269
.equ TOKEN_LABEL,      270
/* Byte operations */
.equ TOKEN_READCHAR,   271
.equ TOKEN_WRITECHAR,  272
/* Symbols */
.equ TOKEN_EQUAL,      273 /* == */
.equ TOKEN_NOTEQUAL,   274 /* != */
.equ TOKEN_LE,         275 /* <= */
.equ TOKEN_GE,         276 /* >= */
.equ TOKEN_ARROW,      277 /* => */
/* End of token */
.equ TOKEN_END,        278

/* Maximum token size */
.equ MAX_TOKEN_LEN, 128 /* NOTE: in future may be changed */
