AS = as
ASFLAGS = --32
LD = ld
LDFLAGS = -melf_i386 --nostdlib

all: rt

rt: main.o lib.o
	$(LD) $(LDFLAGS) -o $@ $^

main.o: main.S
lib.o: lib.S

.S.o:
	$(AS) $(ASFLAGS) -o $@ $<

.PHONY: clean
clean:
	rm -f *.o rt
