#ifndef CRITIC_FIXED_H
#define CRITIC_FIXED_H

#include <math.h>
#include "zgrocc_isr.h"

static inline void critic_basis_grad_f32(float32_t ed, float32_t eq, float32_t we,
                                          float32_t dphi[][2]) {
    dphi[0][0] = 2.0f*ed;  dphi[0][1] = 0.0f;
    dphi[1][0] = eq;        dphi[1][1] = ed;
    dphi[2][0] = 0.0f;      dphi[2][1] = 2.0f*eq;
    dphi[3][0] = 2.0f*we*ed; dphi[3][1] = 0.0f;
    dphi[4][0] = we*eq;      dphi[4][1] = we*ed;
    dphi[5][0] = 0.0f;       dphi[5][1] = 2.0f*we*eq;
}

static inline void critic_grad_f32(const float32_t *Wc, float32_t dphi[][2],
                                    float32_t grad[2]) {
    grad[0] = 0.0f; grad[1] = 0.0f;
    for (int i = 0; i < NC_DIM; i++) {
        grad[0] += dphi[i][0] * Wc[i];
        grad[1] += dphi[i][1] * Wc[i];
    }
}

static inline void bellman_residual_f32(const float32_t *Wc,
    float32_t ed, float32_t eq, float32_t we,
    float32_t de_d, float32_t de_q,
    float32_t u_d, float32_t u_q,
    float32_t Qd, float32_t Qq, float32_t Rd, float32_t Rq,
    float32_t gamma, float32_t *sigma, float32_t *r_val)
{
    float32_t dphi[NC_DIM][2];
    critic_basis_grad_f32(ed, eq, we, dphi);
    float32_t grad[2];
    critic_grad_f32(Wc, dphi, grad);
    *r_val = Qd*ed*ed + Qq*eq*eq + Rd*u_d*u_d + Rq*u_q*u_q;
    sigma[0] = dphi[0][0]*de_d + dphi[0][1]*de_q;
    sigma[1] = dphi[1][0]*de_d + dphi[1][1]*de_q;
    sigma[2] = dphi[2][0]*de_d + dphi[2][1]*de_q;
    sigma[3] = dphi[3][0]*de_d + dphi[3][1]*de_q;
    sigma[4] = dphi[4][0]*de_d + dphi[4][1]*de_q;
    sigma[5] = dphi[5][0]*de_d + dphi[5][1]*de_q;
}

#endif
