disp('Dynamic parameters identification using PSO for simulated friction')
%% -------------------------------------------Static parameters
%% Signal processing
% In this section the log file will be loaded so that in the end we can
% obtain friction and velocity points to use with PSO algorithm.

joint.position.time = SDOSimTest_Log.x.time;
joint.position.signal = SDOSimTest_Log.x.signals.values;
joint.effort = SDOSimTest_Log.input_signal.signals.values;
%Yaw mass = 8.1
mass_pitch = 4.169;
sigma2_pitch = 1.295;
sigma2 = sigma2_pitch;
mass = mass_pitch;
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

% Generate fourier fit
fourier = fit(time, position, 'Fourier8');
[dx_est, ddx_est] = getVelAccFourier(fourier, time);

% u = T_fr + M * ddx
% T_fr = sigma0 * x + (sigma1 + sigma2) * dx
b = effort - mass*ddx_est - sigma2*dx_est;
A = [position dx_est];

% Sigma otim = [Sigma0 (Sigma1 + Sigma2)]
sigma_otim = linsolve(A,b)

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