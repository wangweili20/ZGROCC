# TMS320F28379D build configuration
CC       = cl2000
CFLAGS   = --silicon_version=28 -O2 --fp_mode=relaxed --define=CPU1 \
           --define=_FLASH --diag_warning=225
LDFLAGS  = --rom_model --stack_size=0x400 --heap_size=0x200
DEVICE   = TMS320F28379D
FLASHCMD = dsp/config/f28379d_flash.cmd
