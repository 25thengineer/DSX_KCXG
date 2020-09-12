mips-sde-elf-as testbench_lhx.s -o testbench_lhx.o
mips-sde-elf-ld -T ram.ld testbench_lhx.o -o testbench_lhx.om
mips-sde-elf-objcopy -O binary testbench_lhx.om testbench_lhx.bin
./Bin2Mem.exe -f testbench_lhx.bin -o testbench_lhx.data
