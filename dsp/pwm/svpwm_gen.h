#ifndef SVPWM_GEN_H
#define SVPWM_GEN_H
typedef float float32_t;
void SVPWM_CalcSector(float32_t valpha, float32_t vbeta, float32_t Vdc,
                      float32_t *Ta, float32_t *Tb, float32_t *Tc);
#endif
