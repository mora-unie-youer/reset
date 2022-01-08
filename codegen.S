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
