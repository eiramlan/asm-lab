# Fun with Assembly (x86)

We use **one consistent toolchain** so everyone runs the same commands on any machine.

- **Assembler:** NASM (Intel syntax)  
- **Targets:** Linux **IA-32 (32-bit)** for most labs; Linux **x86-64** also supported  
- **Environment:**
  - **Recommended (zero install):** GitHub **Codespaces** (in your browser)
  - **Fallback:** **Docker** locally (Windows/WSL, macOS, Linux)

You do **not** need Python/Jupyter/Emu86.

---

## 1) Run in GitHub Codespaces (recommended)

1. Open the repo on GitHub → **Code** → **Open with Codespaces** → **Create codespace**.  
2. Wait for the terminal to appear (tools auto-installed).  
3. Build and run a programme:

```bash
# 32-bit (IA-32) — used by most exercises
make PROG=hello MODE=32
make run

# 64-bit (if you are using a 64-bit example)
make PROG=hello
make run
```

> Tip: edit files directly in the browser editor.

---

## 2) Run locally with Docker

1. Install Docker (Windows users: enable WSL2).  
2. In a terminal at the repo root:

```bash
docker build --platform=linux/amd64 -t asm-lab .
docker run --platform=linux/amd64 --rm -it -v "$PWD":/lab -w /lab asm-lab
```

3. Inside the container, use the same `make` commands as in Codespaces.

---

## 3) Files in this repo

- `Makefile` — builds/runs both 32-bit and 64-bit code  
- `template32.asm` — minimal 32-bit skeleton (Linux, pure syscalls)  
- `template64.asm` — minimal 64-bit skeleton (Linux, pure syscalls)  
- Samples: `arith*.asm`, `twos*.asm`, `part3.asm`, `palindrome*.asm`, `part5.asm`, etc.

Creating a new file? Start from the relevant template.

---

## 4) Build and run (cheat sheet)

**32-bit (IA-32) — most exercises**
```bash
make PROG=<filename without .asm> MODE=32
make run
```

**64-bit (optional)**
```bash
make PROG=<filename without .asm>      # MODE defaults to 64
make run
```

---

## 5) How we verify results

**Arithmetic tasks (Part 1, etc.)**  
Programmes set **EAX** to the result and **exit(code = EAX)**. Check with:
```bash
./arith && echo $?
# e.g. 6, 43, 61, 91
```

**Palindrome (Part 4)**  
Programme exits with **1** (palindrome) or **0** (not):
```bash
./palindrome && echo $?
```

**Arrays / Loops / Sort (Parts 3 and 5)**  
Some programmes **dump raw array bytes** to stdout. Pretty-print with standard tools:
```bash
./part3 | od -An -td4      # show as 32-bit signed decimals
./part5 | od -An -td4      # e.g. 1 2 3 4 5 8
```

A few examples also print single digits directly using `write(1, ...)` when values are 0–9.

---

## 6) Makefile switches (optional)

Add these flags to your `make` command if needed:

- `MODE=32` — build 32-bit (IA-32). Omit for 64-bit.  

Examples:
```bash
make clean
make PROG=part3 MODE=32
```

---

## 7) Minimal assembly templates

**`template32.asm`**
```asm
global _start
section .text
_start:
    ; your 32-bit code here
    mov eax, 1      ; sys_exit
    xor ebx, ebx    ; status 0
    int 0x80
```

**`template64.asm`**
```asm
global _start
section .text
_start:
    ; your 64-bit code here
    xor rdi, rdi    ; status 0
    mov rax, 60     ; sys_exit
    syscall
```

---

## 8) Troubleshooting

- **`nasm: fatal: unrecognised output format`**  
  You probably forgot `MODE=32` for a 32-bit file:
  ```bash
  make PROG=name MODE=32
  ```

- **`Relocations in generic ELF (EM:62)` / "file in wrong format"**  
  Mixed 32/64-bit objects. Rebuild clean with the right `MODE`:
  ```bash
  make clean
  make PROG=name MODE=32   # or omit MODE for 64-bit
  ```

- **Segmentation fault after piping to `od`/`xxd`**  
  Your programme wrote the bytes but did not call `exit`. Ensure the final lines are:
  ```asm
  xor ebx, ebx
  mov eax, 1
  int 0x80
  ```

- **NASM complains about a line (comma/colon/decorator...)**  
  Replace curly quotes/odd spaces. Re-type strings with straight quotes `"..."` and keep labels/ops in plain ASCII.

---

## 9) TL;DR

- **Codespaces:** open repo → create codespace →  
  `make PROG=part3 MODE=32` → `make run` → `./part3 | od -An -td4`
- **Local Docker:** build and run the container as above, then the same `make` commands.

Happy hacking 👾
