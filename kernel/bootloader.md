# Bootloader

## Loading
1. BIOS is 16-bit code.
2. BIOS will initialize essential hardwares.
3. BIOS searches for the boot loader signature(0x55AA) on every storage media.
4. BIOS will load the 1st sector(512 byte) from every storage media and search for the bootloader signature on 511th byte and 512th byte.
5. BIOS will load the boot loader into memory address 0x7C00
6. When boot loader is starting to execute, the processor is on "Real Mode".

