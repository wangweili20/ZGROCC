#include "F2837xD_device.h"
void EQEP_Config_17bit(void) {
    EALLOW;
    EQep1Regs.QDECCTL.bit.QSRC = 0;
    EQep1Regs.QEPCTL.bit.QPEN = 1;
    EQep1Regs.QPOSMAX = 131071;
    EQep1Regs.QUPRD = 1000000;
    EDIS;
}
