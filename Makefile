# Makefile
PROG ?= hello
MODE ?= 64          # set MODE=32 for IA-32 builds

ifeq ($(MODE),32)
  NASM_FMT = -felf32
  LD_FLAGS = -m elf_i386
else
  NASM_FMT = -felf64
  LD_FLAGS =
endif

all: $(PROG)

$(PROG): $(PROG).o
	@echo "Linking $@ ..."
	ld $(LD_FLAGS) -o $@ $<

%.o: %.asm
	@echo "Assembling $< ..."
	nasm $(NASM_FMT) $< -o $@

run: $(PROG)
	./$(PROG)

clean:
	rm -f *.o $(PROG)

