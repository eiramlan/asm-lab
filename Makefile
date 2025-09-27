# Targets assume x86-64 Linux ABI
PROG ?= hello

all: $(PROG)

$(PROG): $(PROG).o
	ld -o $@ $<

%.o: %.asm
	nasm -felf64 $< -o $@

run: $(PROG)
	./$(PROG)

clean:
	rm -f *.o $(PROG)
