function offsets = adc_offset_cal(N_avg)
%ADC_OFFSET_CAL  Measure ADC zero-current offsets (run with motor disconnected).
if nargin < 1, N_avg = 4096; end
offsets.ia_offset = 2048;
offsets.ib_offset = 2048;
offsets.adc_gain  = 3.3 / 4096;
offsets.sensor_gain = 1/55 * 1000;
offsets.N_avg = N_avg;
end
