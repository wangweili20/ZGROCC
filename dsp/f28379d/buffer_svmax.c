#include "buffer_svmax.h"
#include <string.h>
#include <math.h>

void svmax_buffer_init(CriticBuffer_t *buf) {
    memset(buf, 0, sizeof(CriticBuffer_t));
}

static float32_t compute_diag_min(const CriticBuffer_t *buf) {
    float32_t dmin = 1e15f;
    for (int i = 0; i < NC_DIM; i++) {
        float32_t acc = 0.0f;
        for (int k = 0; k < buf->count; k++)
            acc += buf->sigma[i][k] * buf->sigma[i][k];
        if (acc < dmin) dmin = acc;
    }
    return dmin;
}

void svmax_buffer_try_insert(CriticBuffer_t *buf, const float32_t *sigma, float32_t r) {
    if (buf->count < BUFFER_M) {
        for (int i = 0; i < NC_DIM; i++)
            buf->sigma[i][buf->count] = sigma[i];
        buf->r[buf->count] = r;
        buf->count++;
        return;
    }
    float32_t lmin_cur = compute_diag_min(buf);
    int best_j = -1;
    float32_t best_lmin = lmin_cur;
    for (int j = 0; j < BUFFER_M; j++) {
        float32_t trial_min = 1e15f;
        for (int i = 0; i < NC_DIM; i++) {
            float32_t acc = 0.0f;
            for (int k = 0; k < BUFFER_M; k++) {
                float32_t val = (k == j) ? sigma[i] : buf->sigma[i][k];
                acc += val * val;
            }
            if (acc < trial_min) trial_min = acc;
        }
        if (trial_min > best_lmin) {
            best_lmin = trial_min;
            best_j = j;
        }
    }
    if (best_j >= 0) {
        for (int i = 0; i < NC_DIM; i++)
            buf->sigma[i][best_j] = sigma[i];
        buf->r[best_j] = r;
    }
}

void cl_update_f32(float32_t *Wc, const float32_t *sigma, float32_t r,
                   const CriticBuffer_t *buf, float32_t eta) {
    float32_t ns2 = 0.0f;
    for (int i = 0; i < NC_DIM; i++) ns2 += sigma[i]*sigma[i];
    float32_t denom = (1.0f + ns2);
    denom *= denom;
    float32_t sWr = r;
    for (int i = 0; i < NC_DIM; i++) sWr += sigma[i]*Wc[i];
    for (int i = 0; i < NC_DIM; i++)
        Wc[i] -= eta * sigma[i] * sWr / denom;
    for (int k = 0; k < buf->count; k++) {
        float32_t ns2k = 0.0f;
        for (int i = 0; i < NC_DIM; i++) ns2k += buf->sigma[i][k]*buf->sigma[i][k];
        float32_t dk = (1.0f + ns2k); dk *= dk;
        float32_t sWrk = buf->r[k];
        for (int i = 0; i < NC_DIM; i++) sWrk += buf->sigma[i][k]*Wc[i];
        for (int i = 0; i < NC_DIM; i++)
            Wc[i] -= eta * buf->sigma[i][k] * sWrk / dk;
    }
}
