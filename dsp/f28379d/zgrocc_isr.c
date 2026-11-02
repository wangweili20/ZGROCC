/*
 * zgrocc_isr.c — ZG-ROCC current-loop ISR for TMS320F28379D CPU1.
 * 10 kHz interrupt, Ts = 100 us.
 */
#include "zgrocc_isr.h"
#include "hal_adc.h"
#include "hal_pwm.h"
#include "hal_encoder.h"
#include "critic_fixed.h"
#include "buffer_svmax.h"

static volatile ZgRoccState_t state;
static CriticBuffer_t cl_buffer;
static float32_t Wc[NC_DIM];
static float32_t e_prev[2] = {0.0f, 0.0f};

__interrupt void ADCB1_ISR(void) {
    uint32_t t_start = CpuTimer0Regs.TIM.all;

    /* --- ADC read + Park transform --- */
    float32_t ia_raw = HAL_ADC_ReadPhaseA();
    float32_t ib_raw = HAL_ADC_ReadPhaseB();
    float32_t ic_raw = -(ia_raw + ib_raw);
    float32_t theta_e = HAL_ENC_GetElecAngle();
    float32_t id, iq;
    park_transform_f32(ia_raw, ib_raw, ic_raw, theta_e, &id, &iq);
    float32_t omega_e = HAL_ENC_GetElecSpeed();

    /* --- tracking error --- */
    float32_t ed = id - state.id_ref;
    float32_t eq = iq - state.iq_ref;

    /* --- feedforward --- */
    float32_t uff_d = state.Rs0 * state.id_ref - state.Lq0 * omega_e * state.iq_ref;
    float32_t uff_q = state.Rs0 * state.iq_ref + state.Ld0 * omega_e * state.id_ref
                      + state.psi_f0 * omega_e;

    /* --- critic gradient (6 basis) --- */
    float32_t dphi[NC_DIM][2];
    critic_basis_grad_f32(ed, eq, omega_e, dphi);

    /* --- actor / disturbance --- */
    float32_t grad_V[2];
    critic_grad_f32(Wc, dphi, grad_V);
    float32_t u_hat_d = -0.5f * state.Rinv_d * state.B_d * grad_V[0];
    float32_t u_hat_q = -0.5f * state.Rinv_q * state.B_q * grad_V[1];

    float32_t ud = uff_d + u_hat_d;
    float32_t uq = uff_q + u_hat_q;

    /* --- voltage saturation --- */
    float32_t u_mag = sqrtf(ud*ud + uq*uq);
    float32_t u_max = state.Vdc * INV_SQRT3;
    uint8_t sat_flag = 0;
    if (u_mag > u_max) {
        float32_t scale = u_max / u_mag;
        ud *= scale;
        uq *= scale;
        sat_flag = 1;
    }

    /* --- apply PWM --- */
    float32_t va, vb, vc;
    inv_park_f32(ud, uq, theta_e, &va, &vb, &vc);
    HAL_PWM_SetDuty(va, vb, vc, state.Vdc);

    /* --- finite-difference de/dt --- */
    float32_t de_d = (ed - e_prev[0]) * state.Ts_inv;
    float32_t de_q = (eq - e_prev[1]) * state.Ts_inv;
    e_prev[0] = ed;
    e_prev[1] = eq;

    /* --- bellman residual --- */
    float32_t sigma[NC_DIM];
    float32_t r_val;
    bellman_residual_f32(Wc, ed, eq, omega_e, de_d, de_q,
                         u_hat_d, u_hat_q, state.Q_d, state.Q_q,
                         state.R_d, state.R_q, state.gamma, sigma, &r_val);

    /* --- buffer management --- */
    svmax_buffer_try_insert(&cl_buffer, sigma, r_val);

    /* --- concurrent learning update --- */
    float32_t eta = sat_flag ? (state.eta_c * 0.5f) : state.eta_c;
    cl_update_f32(Wc, sigma, r_val, &cl_buffer, eta);

    /* --- timing measurement --- */
    uint32_t t_end = CpuTimer0Regs.TIM.all;
    state.isr_ticks = t_start - t_end;

    AdcbRegs.ADCINTFLGCLR.bit.ADCINT1 = 1;
    PieCtrlRegs.PIEACK.all = PIEACK_GROUP1;
}
