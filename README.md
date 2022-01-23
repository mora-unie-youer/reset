# Reset
Programming language firstly written using GNU Assembly.
The main goal is not only create it in assembly, but also bootstrap it.
## Compiling
To compile `rtc` binary from Assembly just run:
```
make
```
To compile `rtc` binary from Reset using `rtc` just run:
```
./rtc <reset.rt >reset.S
as --32 -o reset.o reset.S
ld -melf_i386 -o reset reset.o
```
