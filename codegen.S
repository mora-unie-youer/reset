.data
/* Program segments */
.equ TEXT_SEGMENT, 0
.equ DATA_SEGMENT, 1
.equ RODATA_SEGMENT, 2
/* Current segment */
segment: .long -1 /* -1 here to print first segment too */

.section .rodata
/* Segments */
segments_text: .long text_text, data_text, rodata_text
text_text:     .string ".text\n"
data_text:     .string ".data\n"
rodata_text:   .string ".section .rodata\n"
/* Assembler instructions */
/* GAS macros */
comm_text:     .string ".comm "
global_text:   .string ".global "
long_text:     .string ".long "
string_text:   .string ".string "
/* Arithmetic/bit operations */
addl_text:     .string "\taddl "
subl_text:     .string "\tsubl "
imul_text:     .string "\timul "
idiv_text:     .string "\tidiv "
negl_text:     .string "\tnegl "
shll_text:     .string "\tshll "
shrl_text:     .string "\tshrl "
andl_text:     .string "\tandl "
orl_text:      .string "\torl "
xorl_text:     .string "\txorl "
notl_text:     .string "\tnotl "
cmpl_text:     .string "\tcmpl "
/* Calls/functions/jumps */
call_text:     .string "\tcall "
int_text:      .string "\tint "
label_text:    .string "_label"
leave_text:    .string "\tleave"
ret_text:      .string "\tret"
jmp_text:      .string "\tjmp "
je_text:       .string "\tje "
/* Stack */
pushf_text:    .string "\tpushf"
pushl_text:    .string "\tpushl "
popl_text:     .string "\tpopl "
/* Register/memory operations */
decl_text:     .string "\tdecl "
incl_text:     .string "\tincl "
leal_text:     .string "\tleal "
movl_text:     .string "\tmovl "
movsbl_text:   .string "\tmovsbl "
movzbl_text:   .string "\tmovzbl "
/* Flag operations */
setg_text:     .string "\tsetg "
setge_text:    .string "\tsetge "
setl_text:     .string "\tsetl "
setle_text:    .string "\tsetle "
sete_text:     .string "\tsete "
setne_text:    .string "\tsetne "
/* Registers */
al_text:       .string "%al"
eax_text:      .string "%eax"
ebx_text:      .string "%ebx"
ecx_text:      .string "%ecx"
edx_text:      .string "%edx"
esi_text:      .string "%esi"
edi_text:      .string "%edi"
esp_text:      .string "%esp"
ebp_text:      .string "%ebp"


.text
_change_segment:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax /* fetching segment number */
	cmpl segment, %eax /* if already set -> return */
	je 1f
	movl %eax, segment /* setting segment variable */
	movl segments_text(,%eax,4), %eax /* fetching segment set text */
	pushl %eax
	call puts
1:
	leave
	ret

.global enter_text_segment, enter_data_segment, enter_rodata_segment
enter_text_segment:
	pushl $TEXT_SEGMENT
	call _change_segment
	addl $4, %esp
	ret
enter_data_segment:
	pushl $DATA_SEGMENT
	call _change_segment
	addl $4, %esp
	ret
enter_rodata_segment:
	pushl $RODATA_SEGMENT
	call _change_segment
	addl $4, %esp
	ret

.global newline, comma
/* Print newline char */
newline:
	subl $1, %esp /* newline_char */
	movb $'\n, (%esp)
	call putc /* printing char */
	addl $1, %esp
	ret
/* Print comma char */
comma:
	subl $1, %esp /* comma_char */
	movb $',, (%esp)
	call putc /* printing char */
	addl $1, %esp
	ret

/* Prints full pushl instruction (with register) */
_pushl:
	subl $4, %esp /* pushl_text/register_text */
	movl $pushl_text, (%esp)
	call puts /* printing pushl instruction */
	movl 8(%esp), %eax /* fetching register text */
	movl %eax, (%esp)
	call puts /* printing instruction */
	call newline
	addl $4, %esp
	ret

/* Prints full popl instruction (with register) */
_popl:
	subl $4, %esp /* popl_text/register_text */
	movl $popl_text, (%esp)
	call puts /* printing popl instruction */
	movl 8(%esp), %eax /* fetching register text */
	movl %eax, (%esp)
	call puts /* printing instruction */
	call newline
	addl $4, %esp
	ret

/* Creates pushl and popl instruction for register */
.macro _push_pop reg
.global pushl_\reg, popl_\reg
pushl_\reg:
	pushl $\reg\()_text
	call _pushl
	addl $4, %esp
	ret
popl_\reg:
	pushl $\reg\()_text
	call _popl
	addl $4, %esp
	ret
.endm
_push_pop eax
_push_pop ebx
_push_pop ecx
_push_pop edx
_push_pop esi
_push_pop edi
_push_pop ebp

/* Creates function that prints instruction/register */
.macro _keyword keyword
.global \keyword
\keyword:
	pushl $\keyword\()_text
	call puts
	addl $4, %esp
	ret
.endm
/* GAS macros */
_keyword comm
_keyword global
_keyword long
_keyword string
/* Arithmetic/bit operations */
_keyword addl
_keyword subl
_keyword imul
_keyword idiv
_keyword negl
_keyword shll
_keyword shrl
_keyword andl
_keyword orl
_keyword xorl
_keyword notl
_keyword cmpl
/* Calls/functions/jumps */
_keyword call
_keyword int
_keyword leave
_keyword ret
_keyword jmp
_keyword je
/* Stack */
_keyword pushf
_keyword pushl
_keyword popl
/* Register/memory operations */
_keyword decl
_keyword incl
_keyword leal
_keyword movl
_keyword movsbl
_keyword movzbl
/* Flag operations */
_keyword setg
_keyword setge
_keyword setl
_keyword setle
_keyword sete
_keyword setne
/* Registers */
_keyword al
_keyword eax
_keyword ebx
_keyword ecx
_keyword edx
_keyword esi
_keyword edi
_keyword esp
_keyword ebp

/* Works like `enter` instruction without subtracting */
.global enter_stack
enter_stack:
	call pushl_ebp
	call movl
	call esp
	call comma
	call ebp
	call newline
	ret

_address_stack:
	subl $1, %esp
	movb $'(, (%esp)
	call putc
	call ebp
	movb $'), (%esp)
	call putc
	addl $1, %esp
	ret

/* Variables definition */
.global argument, variable
argument:
	subl $4, %esp /* string_var/char_var/number_var */
	movl 8(%esp), %eax /* number of argument */
	addl $2, %eax /* we have to skip 2 places in stack */
	imul $4, %eax /* getting offset in stack */
	movl %eax, (%esp)
	call putd /* printing offset */
	call _address_stack /* we are applying offset to stack */
	addl $4, %esp
	ret
variable:
	subl $4, %esp /* string_var/char_var/number_var */
	movl $'-, %eax /* variables are on negative side */
	movb %al, (%esp)
	call putc /* printing minus sign */
	movl 8(%esp), %eax /* number of argument */
	addl $1, %eax /* we have to offset 4 bytes for variable */
	imul $4, %eax /* getting offset in stack */
	movl %eax, (%esp)
	call putd /* printing offset */
	call _address_stack /* we are applying offset to stack */
	addl $4, %esp
	ret

/* Print value literal */
.global value
value:
	subl $4, %esp /* char/value */
	movb $'$, (%esp)
	call putc /* Printing dollar sign */
	movl 8(%esp), %eax /* loading value */
	movl %eax, (%esp)
	call putd /* printing number */
	addl $4, %esp
	ret

/* Labels */
.global label, label_def, label_address
/* Print label name */
label:
	subl $4, %esp /* label_text/label_id */
	movl $label_text, (%esp)
	call puts /* printing label_text */
	movl 8(%esp), %eax /* fetching label_id */
	movl %eax, (%esp)
	call putd /* printing label_id */
	addl $4, %esp
	ret
/* Define label */
label_def:
	subl $4, %esp /* label_id/char */
	movl 8(%esp), %eax /* fetching label_id */
	movl %eax, (%esp)
	call label /* printing label name */
	movb $':, (%esp)
	call putc /* printing colon symbol */
	addl $4, %esp
	ret
label_address:
	subl $4, %esp /* char/label_id */
	movb $'$, (%esp)
	call putc /* printing dollar sign */
	movl 8(%esp), %eax /* fetching label_id */
	movl %eax, (%esp)
	call label /* printing label name */
	addl $4, %esp
	ret
