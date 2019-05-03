%% Run simulation

%% Static
% Create a test to acquire system velocity (output) and torque (input) to
% use with Particle Swarm Optimization

N = 100;
angular_vel = linspace(0, 0.03, N+1); % rad/s
FileName=['log_Fr_ss_p_',datestr(now, 'yy-mmm-dd-HH-MM-SS')];
u_ss = zeros(N,1);
dx_ss = zeros(N,1);
tfinal_ss = 80;

k = 1;
for ref_angle = angular_vel(2:end)
    tol_ss = ref_angle*5e-3;
    ctrl_selector = 2;
    sim_result = sim('LuGre_model', tfinal_ss);
    u_ss(k) = sim_result.input_signal.signals.values(end);
    dx_ss(k) = sim_result.dx.signals.values(end);
    k = k + 1;
end
save(FileName, 'dx_ss', 'u_ss');

%% Dynamic

% Create a test to acquire system position (output), velocity, acc and input torque using a sinoidal input
% reference signal
FileName=['log_Fr_dyn_',datestr(now, 'yy-mmm-dd-HH-MM-SS')];
ref_angle = 0.01;
tol_ss = ref_angle*5e-3;
ctrl_selector = 1;
tfinal_dyn = 80;
sim_result = sim('LuGre_model', tfinal_dyn);
u_dyn = sim_result.input_signal.signals.values;
x_dyn = sim_result.x.signals.values;
dx_dyn = sim_result.dx.signals.values;
ddx_dyn = sim_result.ddx.signals.values;
t_dyn = sim_result.x.time;

save(FileName, 'x_dyn', 'dx_dyn', 'ddx_dyn', 'u_dyn', 't_dyn');