Basic implementation of User/Password login system in **Assembly**

# Usage
- Clone the repository
- Run ``$ ./cfep`` on the linux terminal
- Username: aspect | Password: passwd123

# How to edit the source
- Open your linux machine/vm/wsl
- sudo apt update && sudo apt upgrade
- sudo apt install nasm
- Clone the repository
- Locate the to cloned file
- Run ``nasm -f elf64 -o cfep.o cfep.asm && ld cfep.o -o cfep && sudo chmod +x ./cfep && ./cfep`` to compile and run
