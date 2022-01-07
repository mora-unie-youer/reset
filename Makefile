AS = as
ASFLAGS = --32
LD = ld
LDFLAGS = -melf_i386 --nostdlib

all: rt

rt: main.o
	$(LD) $(LDFLAGS) -o $@ $^

main.o: main.S

.S.o:
	$(AS) $(ASFLAGS) -o $@ $<

.PHONY: clean
clean:
	rm -f *.o rt
