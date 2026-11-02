function results = zsg_saddle_sweep(params, omega_vec, Q, R, gamma)
%ZSG_SADDLE_SWEEP  Sweep omega_e, compute P*(omega_e) and Acl eigenvalues.
Rs = params.Rs; Ld = params.Ld; Lq = params.Lq;
B  = diag([1/Ld, 1/Lq]);
Bw = [B, B];
N = length(omega_vec);
results.omega = omega_vec;
results.P = zeros(2,2,N);
results.Ku = zeros(2,2,N);
results.eig_cl = zeros(2,N);
results.dPdomega = zeros(2,2,N);
for k = 1:N
    we = omega_vec(k);
    A = [-Rs/Ld, (Lq/Ld)*we; -(Ld/Lq)*we, -Rs/Lq];
    [P,Ku,Kw] = zsg_hjieq(A, B, Bw, Q, R, gamma);
    results.P(:,:,k) = P;
    results.Ku(:,:,k) = Ku;
    Acl = A - B*Ku + Bw*Kw;
    results.eig_cl(:,k) = eig(Acl);
end
for k = 2:N-1
    dw = omega_vec(k+1) - omega_vec(k-1);
    results.dPdomega(:,:,k) = (results.P(:,:,k+1) - results.P(:,:,k-1))/dw;
end
end
