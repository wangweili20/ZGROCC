#include "isr_timing.h"
void IsrTiming_Init(IsrTiming_t *t) {
    t->ticks_min = 0xFFFFFFFF; t->ticks_max = 0;
    t->ticks_sum = 0; t->count = 0;
}
void IsrTiming_Update(IsrTiming_t *t, uint32_t ticks) {
    if (ticks < t->ticks_min) t->ticks_min = ticks;
    if (ticks > t->ticks_max) t->ticks_max = ticks;
    t->ticks_sum += ticks; t->count++;
}
float IsrTiming_MeanUs(const IsrTiming_t *t, float cpu_mhz) {
    if (t->count == 0) return 0.0f;
    return (float)t->ticks_sum / (float)t->count / cpu_mhz;
}
float IsrTiming_MaxUs(const IsrTiming_t *t, float cpu_mhz) {
    return (float)t->ticks_max / cpu_mhz;
}
