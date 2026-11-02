#ifndef HAL_PWM_H
#define HAL_PWM_H
typedef float float32_t;
void HAL_PWM_Init(float32_t f_sw, float32_t deadtime_us);
void HAL_PWM_SetDuty(float32_t va, float32_t vb, float32_t vc, float32_t Vdc);
#endif
