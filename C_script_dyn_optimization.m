%% Dynamic parameters identification

% Load data
% load('log_Fr_dyn_19-Jan-30-17-43-30.mat');
% t_reduc = t_dyn(end/2:end);
% x_reduc = x_dyn(end/2:end);
% dx_reduc = dx_dyn(end/2:end);
% ddx_reduc = ddx_dyn(end/2:end);
% u_reduc = u_dyn(end/2:end);
load('dyn-friction-sine-yaw.mat')
time = yaw_motor_r.joints_state_samples.time;
time = time - time(1);
interval = [223 290];
ind = find(time >= interval(1), 1) : find(time > interval(2), 1);
position = yaw_motor_r.joints_state_samples.position;
position = position - position(1);
position = position(ind);
effort = yaw_motor_r.joints_state_samples.effort(ind);
time = time(ind);
%Yaw Inertia
mass = 8.1;
sigma2 = 0.1;
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