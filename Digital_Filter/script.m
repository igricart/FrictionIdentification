load('pitch_torque')
y = joint_obs.jointsOut.position; % rad
resolution = 1 / (2^18);
sample_time = 3e-3; % seconds
error_bound = [-resolution/sample_time, resolution/sample_time];
cut_off_frequency = 5; % Herz
% Signal with quatization error
y_k = floor(y/resolution)*resolution;

% Finite Difference
y_k_dot = (y[2:end] - y[1:(end-1)]) / sample_time;

% Finite Difference from Encoder Event
% T Method
