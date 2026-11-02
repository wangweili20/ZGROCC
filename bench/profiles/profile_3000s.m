function prof = profile_3000s()
%PROFILE_3000S  3000-second test cycle specification.
prof.segments = {
    struct('mode','standstill', 't_start',0,   't_end',5);
    struct('mode','ramp_up',    't_start',5,   't_end',15,  'n_final',500);
    struct('mode','cruise',     't_start',15,  't_end',120, 'n_rpm',500);
    struct('mode','ramp_up',    't_start',120, 't_end',180, 'n_final',3000);
    struct('mode','cruise',     't_start',180, 't_end',800, 'n_rpm',3000);
    struct('mode','step_load',  't_start',800, 't_end',810, 'TL',7.0);
    struct('mode','cruise',     't_start',810, 't_end',1200,'n_rpm',3000);
    struct('mode','ramp_down',  't_start',1200,'t_end',1250,'n_final',0);
    struct('mode','reversal',   't_start',1250,'t_end',1400,'n_rpm',-1500);
    struct('mode','ramp_up',    't_start',1400,'t_end',1500,'n_final',3000);
    struct('mode','field_weak', 't_start',1500,'t_end',2200,'n_rpm',4000);
    struct('mode','sine_load',  't_start',2200,'t_end',2600,'f_Hz',5,'amp',3.5);
    struct('mode','rand_torque','t_start',2600,'t_end',2900,'std',2.0,'bw',100);
    struct('mode','ramp_down',  't_start',2900,'t_end',3000,'n_final',0);
};
prof.Ts_log = 100e-6;
end
