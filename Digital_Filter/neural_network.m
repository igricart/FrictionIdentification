%% Pitch angle

%load('pitch_torque');
%t = 45000:47000;

% Load joint parameters
joint_name = 'pitch'
joint = unpack(joint_name);

% Define intervals with constant velocity
disp('Please select only one interval')
interval = interval_definition(joint.position.time, joint.position.signal, joint.position.time, joint.effort,'dynamic')

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

%pos = joint_obs.jointsOut.position(t);
%effort = pitch_motor_r.joints_state_samples.effort(t);
mass_pitch = 4.1691;
sigma2_pitch = 1.2950;
mass_roll = 1.622;
sigma2_roll = 5.0642;
%pos = pos - mean(pos);
net = feedforwardnet([25]);
net.trainParam.min_grad = 1e-11;
net = train(net, time', position');
plot(time,position,time,net(time'));

[ddx, dx, x] = neuralNetDeriv(time', net);
% pos = pos - pos(1);
% t = t - t(1);
% b = effort - mass_pitch*ddx{1} - sigma2_pitch*dx{1};
% A = [pos dx{1}];
% 
% % Sigma otim = [Sigma0 (Sigma1 + Sigma2)]
% % Least Square
% sigma_otim = linsolve(A,b)

% PSO
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


% %% Validate Derivative
% t1 = linspace(0,5,5000);
% f = 1; %Hz
% pos1 = 0.5*sin(2*pi*t1*f);
% net1 = feedforwardnet([100]);
% net1.trainParam.min_gra = 1e-11;
% net1 = train(net1, t1, pos1);
% figure(2);
% plot(t1,pos1,t1,net1(t1));