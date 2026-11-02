#ifndef BUFFER_SVMAX_H
#define BUFFER_SVMAX_H
#include "zgrocc_isr.h"

typedef struct {
    float32_t sigma[NC_DIM][BUFFER_M];
    float32_t r[BUFFER_M];
    float32_t Sigma_diag[NC_DIM];
    int count;
} CriticBuffer_t;

void svmax_buffer_init(CriticBuffer_t *buf);
void svmax_buffer_try_insert(CriticBuffer_t *buf, const float32_t *sigma, float32_t r);
void cl_update_f32(float32_t *Wc, const float32_t *sigma, float32_t r,
                   const CriticBuffer_t *buf, float32_t eta);
#endif
