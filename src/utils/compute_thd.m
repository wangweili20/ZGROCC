function thd_pct = compute_thd(signal, fs, f_fundamental, n_harmonics)
%COMPUTE_THD  Current THD from time-domain signal via FFT.
if nargin < 4, n_harmonics = 50; end
N = length(signal);
Y = fft(signal);
Y_mag = 2*abs(Y(1:floor(N/2)+1))/N;
df = fs/N;
idx_fund = round(f_fundamental/df) + 1;
P_fund = Y_mag(idx_fund)^2;
P_harm = 0;
for h = 2:n_harmonics
    idx_h = round(h*f_fundamental/df) + 1;
    if idx_h <= length(Y_mag)
        P_harm = P_harm + Y_mag(idx_h)^2;
    end
end
thd_pct = 100*sqrt(P_harm)/sqrt(P_fund);
end
