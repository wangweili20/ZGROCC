#ifndef ISR_TIMING_H
#define ISR_TIMING_H
#include <stdint.h>
typedef struct {
    uint32_t ticks_min;
    uint32_t ticks_max;
    uint32_t ticks_sum;
    uint32_t count;
} IsrTiming_t;
void IsrTiming_Init(IsrTiming_t *t);
void IsrTiming_Update(IsrTiming_t *t, uint32_t ticks);
float IsrTiming_MeanUs(const IsrTiming_t *t, float cpu_mhz);
float IsrTiming_MaxUs(const IsrTiming_t *t, float cpu_mhz);
#endif
