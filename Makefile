# -------- Settings --------
PROG ?= hello
MODE ?= 64        # use MODE=32 for your slide-era code

ifeq ($(MODE),64)
  ASM_FMT = elf64
  LD_EMU  = elf_x86_64
else
  ASM_FMT = elf32
  LD_EMU  = elf_i386
endif

all: $(PROG)

$(PROG): $(PROG).o
	@echo "Linking $@ ..."
	ld -m $(LD_EMU) -o $@ $<

%.o: %.asm
	@echo "Assembling $< ..."
	nasm -f$(ASM_FMT  ) $< -o $@

run: $(PROG)
	./$(PROG)

clean:
	rm -f *.o $(PROG)

.PHONY: all run clean
