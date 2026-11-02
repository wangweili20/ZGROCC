function run_all_tests()
%RUN_ALL_TESTS  Execute all unit tests.
addpath(genpath(fileparts(fileparts(mfilename('fullpath')))));
test_hjieq_nominal();
test_playability();
test_buffer_rank();
test_voltage_saturation();
test_deadtime_model();
fprintf('\n=== ALL TESTS PASSED ===\n');
end
