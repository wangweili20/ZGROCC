#ifndef ZGROCC_ISR_H
#define ZGROCC_ISR_H

#include <stdint.h>
#include "F2837xD_device.h"

#define NC_DIM       6
#define BUFFER_M     30
#define INV_SQRT3    0.57735026919f

typedef float float32_t;

typedef struct {
    float32_t id_ref, iq_ref;
    float32_t Rs0, Ld0, Lq0, psi_f0;
    float32_t B_d, B_q;
    float32_t Rinv_d, Rinv_q;
    float32_t Q_d, Q_q, R_d, R_q;
    float32_t gamma, eta_c;
    float32_t Vdc, Ts_inv;
    uint32_t  isr_ticks;
} ZgRoccState_t;

__interrupt void ADCB1_ISR(void);

#endif
