# Targets assume x86-64 Linux ABI
PROG ?= hello

all: $(PROG)

$(PROG): $(PROG).o
	@echo "Linking $@ ..."
	gcc -nostartfiles -no-pie -o $@ $<

%.o: %.asm
	@echo "Assembling $< ..."
	nasm -felf64 $< -o $@

run: $(PROG)
	./$(PROG)

clean:
	rm -f *.o $(PROG)
