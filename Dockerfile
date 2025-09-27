# x86-64 NASM + GCC toolchain for teaching labs
FROM ubuntu:24.04

# Keep image small; install only what we need
RUN apt-get update && apt-get install -y --no-install-recommends \
      nasm gcc make \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /lab
CMD ["/bin/bash"]
