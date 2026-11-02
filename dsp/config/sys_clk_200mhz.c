#include "F2837xD_device.h"
void SysCtl_Init_200MHz(void) {
    EALLOW;
    ClkCfgRegs.CLKSRCCTL1.bit.OSCCLKSRCSEL = 0;
    ClkCfgRegs.SYSPLLMULT.bit.IMULT = 20;
    ClkCfgRegs.SYSCLKDIVSEL.bit.PLLSYSCLKDIV = 1;
    EDIS;
}
