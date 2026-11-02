function plot_step_response(t, iq_hist, iq_ref, controllers)
%PLOT_STEP_RESPONSE  Fig 4(a): iq step response comparison.
figure; hold on;
colors = lines(length(controllers));
for c = 1:length(controllers)
    plot(t*1e3, iq_hist(c,:), 'Color', colors(c,:), 'LineWidth', 1.2);
end
plot(t*1e3, iq_ref, 'k--', 'LineWidth', 0.8);
xlabel('Time (ms)'); ylabel('i_q (A)');
legend(controllers{:}, 'Reference');
grid on;
end
