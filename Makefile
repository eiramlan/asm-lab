# -------- Settings --------
PROG ?= hello
MODE ?= 64

# Normalise MODE (trim spaces/tabs)
MODE_CLEAN := $(strip $(MODE))

# -------- Format / Linker emulation --------
ifeq ($(MODE_CLEAN),64)
  ASM_FMT := elf64
  LD_EMU  := elf_x86_64
else ifeq ($(MODE_CLEAN),32)
  ASM_FMT := elf32
  LD_EMU  := elf_i386
else
  $(error MODE must be 64 or 32 (got '$(MODE)'))
endif

# -------- Targets --------
all: $(PROG)

$(PROG): $(PROG).o
	@echo "Linking $@ ..."
	ld -m $(LD_EMU) -o $@ $<

%.o: %.asm
	@echo "Assembling $< ..."
	nasm -f $(ASM_FMT) $< -o $@

run: $(PROG)
	./$(PROG)

clean:
	rm -f *.o $(PROG)

.PHONY: all run clean
