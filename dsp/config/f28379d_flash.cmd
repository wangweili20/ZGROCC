MEMORY
{
    FLASH_BANK0 (RX) : origin = 0x080000, length = 0x10000
    FLASH_BANK1 (RX) : origin = 0x090000, length = 0x10000
    RAMLS0      (RW) : origin = 0x008000, length = 0x000800
    RAMLS1      (RW) : origin = 0x008800, length = 0x000800
    RAMGS0      (RW) : origin = 0x00C000, length = 0x001000
}
SECTIONS
{
    .text    : > FLASH_BANK0
    .cinit   : > FLASH_BANK0
    .bss     : > RAMLS0
    .data    : > RAMLS1
    .stack   : > RAMGS0
}
