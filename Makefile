all:
	as --32 controle-rh.s -o controle-rh.o
	ld -m elf_i386 -l c -dynamic-linker /lib/ld-linux.so.2 controle-rh.o -o controle-rh

clean:
	rm -rf *.o controle-rh