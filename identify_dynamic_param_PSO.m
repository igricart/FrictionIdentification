%% Dynamic parameters identification
function [sigma_otim] = identify_dynamic_param(joint_name,sigma2, mass)
%Yaw mass = 8.1

disp('Dynamic parameters identification using PSO')
%% -------------------------------------------Static parameters
%% Signal processing
% In this section the log file will be loaded so that in the end we can
% obtain friction and velocity points to use with PSO algorithm.

% Load joint parameters
joint = unpack(joint_name);

% Define intervals with constant velocity
disp('Please select only one interval')
interval = interval_definition(joint.position.time, joint.position.signal, joint.position.time, joint.effort,'dynamic');

time = joint.position.time;
time = time - time(1);
ind = find(time >= interval(1), 1) : find(time > interval(2), 1);
position = joint.position.signal;
position = position(ind);
effort = joint.effort(ind);
time = time(ind);
position = position - position(1);
time = time - time(1);

%Yaw Inertia
disp('Make sure the inertia is correct and set sigma2 according to the value obtained from identify_static_param');
% Obs.: Remember to filter position data to use the signals after system
% stabilization 

net = feedforwardnet(25);
net.trainParam.min_grad = 1e-11;
net = train(net, time, position');
plot(time,position,time,net(time));

[ddx, dx, x] = neuralNetDeriv(time, net);

%% PSO
%Param settings
%[Sigma0 Sigma1]
lower_bound = [0.3 1];
upper_bound = [1e6 1e6];
barrier_selector = 1;
popSize = 100;

% Prepare functions
fcost = @(y) getCost_dynamic(y, x, dx{1}, ddx{1}, effort, mass_pitch, sigma2_pitch);
fconstraint = @(cx) fun_constraint(cx, upper_bound, lower_bound);
fbarrier = @(gx) fun_barrier(gx, barrier_selector);

% Set seed for repeatability
rng('default');

% Run PSO algorithm
otim = dynamic_optim(fcost, fconstraint, fbarrier, upper_bound, lower_bound, popSize);

figure();
title(joint_name);
hold on;
grid minor;
plot(b + sigma2 * dx_est);
plot(A*sigma_otim + sigma2 * dx_est);
legend('Friction', 'Optmized Friction')
xlabel('time(s)')
ylabel('Torque(N.m)')
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