%% Test Procedure
% Identify Fc for each position


%% Run simulation
% Create a test to acquire system velocity (output) and torque (input) to
% use with Particle Swarm Optimization

N = 100;
angular_vel = linspace(0, 0.03, N+1); % rad/s
FileName=['log_Fr_ss_p_',datestr(now, 'yy-mmm-dd-HH-MM-SS')];
u_ss = zeros(N,1);
dx_ss = zeros(N,1);
tfinal = 60;

k = 1;
for ref_angle = angular_vel(2:end)
    tol_ss = ref_angle*5e-3;
    sim_result = sim('friction_Pcontrol', tfinal);
    u_ss(k) = sim_result.input_signal.signals.values(end);
    dx_ss(k) = sim_result.dx.signals.values(end);
    k = k + 1;
end

save(FileName, 'dx_ss', 'u_ss');