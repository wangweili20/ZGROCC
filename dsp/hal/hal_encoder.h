#ifndef HAL_ENCODER_H
#define HAL_ENCODER_H
typedef float float32_t;
void HAL_ENC_Init(int pn);
float32_t HAL_ENC_GetElecAngle(void);
float32_t HAL_ENC_GetElecSpeed(void);
#endif
