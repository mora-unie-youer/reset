AS = as
ASFLAGS = --32
LD = ld
LDFLAGS = -melf_i386 --nostdlib

all: rtc

rtc: main.o lib.o lexer.o
	$(LD) $(LDFLAGS) -o $@ $^

main.o: main.S
lib.o: lib.S
lexer.o: lexer.S

.S.o:
	$(AS) $(ASFLAGS) -o $@ $<

.PHONY: clean
clean:
	rm -f *.o rtc
