#include "F2837xD_device.h"
void ADC_SOC_Config(void) {
    EALLOW;
    AdcbRegs.ADCSOC0CTL.bit.CHSEL = 0;
    AdcbRegs.ADCSOC0CTL.bit.ACQPS = 14;
    AdcbRegs.ADCSOC0CTL.bit.TRIGSEL = 5;
    AdcbRegs.ADCSOC1CTL.bit.CHSEL = 1;
    AdcbRegs.ADCSOC1CTL.bit.ACQPS = 14;
    AdcbRegs.ADCSOC1CTL.bit.TRIGSEL = 5;
    AdcbRegs.ADCINTSEL1N2.bit.INT1SEL = 1;
    AdcbRegs.ADCINTSEL1N2.bit.INT1E = 1;
    EDIS;
}
