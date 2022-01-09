.include "token.S"

.data
/* Program segments */
.equ TEXT_SEGMENT, 0
.equ DATA_SEGMENT, 1
.equ RODATA_SEGMENT, 2
/* Current segment */
segment: .long TEXT_SEGMENT

.section .rodata
/* Segments */
segments_text: .long text_text, data_text, rodata_text
text_text:     .string ".text\n"
data_text:     .string ".data\n"
rodata_text:   .string ".section .rodata\n"
/* Assembler instructions */
/* GAS macros */
comm_text:     .string ".comm "
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
movl_text:     .string "\tmovl "
/* Registers */
eax_text:       .string "%eax"
ebx_text:       .string "%ebx"
ecx_text:       .string "%ecx"
edx_text:       .string "%edx"
esi_text:       .string "%esi"
edi_text:       .string "%edi"
esp_text:       .string "%esp"
ebp_text:       .string "%ebp"

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
