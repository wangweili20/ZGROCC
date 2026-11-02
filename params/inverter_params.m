function inv = inverter_params()
%INVERTER_PARAMS  IGBT inverter specification.
inv.Vdc   = 540;      % DC-link voltage [V]
inv.f_sw  = 10e3;     % switching frequency [Hz]
inv.Ts_sw = 1/inv.f_sw;
inv.Td    = 2.5e-6;   % dead time [s]
inv.Vce   = 1.6;      % IGBT on-state voltage [V]
inv.Vd    = 0.7;      % diode forward drop [V]
inv.Ton   = 0.3e-6;   % turn-on delay [s]
inv.Toff  = 0.5e-6;   % turn-off delay [s]
end
