function gains = baseline_smc_dob()
%BASELINE_SMC_DOB  Sliding-mode + DOB baseline gains.
gains.lambda_d = 500;
gains.lambda_q = 500;
gains.k_smc = 50;
gains.dob_bandwidth = 2000;
gains.dob_order = 2;
end
