%% Dynamic parameters identification
function [sigma_otim] = identify_dynamic_param(joint_name,sigma2, mass)
%Yaw mass = 8.1

disp('Dynamic parameters identification \n')
%% -------------------------------------------Static parameters
%% Signal processing
% In this section the log file will be loaded so that in the end we can
% obtain friction and velocity points to use with PSO algorithm.

% Load joint parameters
joint = unpack(joint_name);

% Define intervals with constant velocity
disp('Please select only one interval')
interval = interval_definition(joint.position.time, joint.effort, joint.position.time, joint.position.signal);

time = joint.position.time;
time = time - time(1);
%interval = [223 290];
ind = find(time >= interval(1), 1) : find(time > interval(2), 1);
position = joint.position.signal;
position = position - position(1);
position = position(ind);
effort = joint.effort(ind);
time = time(ind);

%Yaw Inertia
disp('Make sure the inertia is correct and set sigma2 according to the value obtained from identify_static_param');
mass = 8.1;
% Obs.: Remember to filter position data to use the signals after system
% stabilization 

% Generate fourier fit
fourier = fit(time, position, 'Fourier8');
[dx_est, ddx_est] = getVelAccFourier(fourier, time);

b = effort - mass*ddx_est - sigma2*dx_est;
A = [position dx_est];

% Sigma otim = [Sigma0 (Sigma1 + Sigma2)]
sigma_otim = linsolve(A,b);

figure();
hold on;
plot(b);
plot(A*sigma_otim);

%% Plot
% 
% subplot(1, 2, 1);
% plot(time, dx_reduc, 'b-', t_reduc, dx_est, 'r--');
% legend('real', 'estimate');
% grid on;
% %
% subplot(1, 2, 2);
% plot(t_reduc, ddx_reduc, 'b-', t_reduc, ddx_est, 'r--');
% legend('real', 'estimate');
% grid on;