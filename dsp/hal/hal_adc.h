#ifndef HAL_ADC_H
#define HAL_ADC_H
#include "F2837xD_device.h"
typedef float float32_t;
void HAL_ADC_Init(void);
float32_t HAL_ADC_ReadPhaseA(void);
float32_t HAL_ADC_ReadPhaseB(void);
#endif
