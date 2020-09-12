mips-sde-elf-as testbench_wh.s -o testbench_wh.o
mips-sde-elf-ld -T ram.ld testbench_wh.o -o testbench_wh.om
mips-sde-elf-objcopy -O binary testbench_wh.om testbench_wh.bin
./Bin2Mem.exe -f testbench_wh.bin -o testbench_wh.data
