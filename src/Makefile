GCC=arm-none-eabi-gcc

main.elf: startup.S cpu_test.S main.c
	${GCC} -mtune=cortex-m3 -mthumb  -mno-thumb-interwork --specs=nosys.specs -nostartfiles -T linker.ld -Wl,--gc-sections -g3 -o $@ $^
	
clean:
	rm -rf main.elf
