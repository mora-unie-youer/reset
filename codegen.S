.include "token.S"

.data
/* Program segments */
.equ TEXT_SEGMENT, 0
.equ DATA_SEGMENT, 1
.equ RODATA_SEGMENT, 2
/* Current segment */
segment: .long TEXT_SEGMENT
