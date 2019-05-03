%% Script to identify friction parameters
function [friction, vel, otim, interval] = identify_static_param(joint_name, friction_joint, vel_joint)

%% -------------------------------------------Static parameters
%% Signal processing
% In this section the log file will be loaded so that in the end we can
% obtain friction and velocity points to use with PSO algorithm.

% % Load joint parameters
% joint = unpack(joint_name);
% 
% % Define intervals with constant velocity
% interval = interval_definition(joint.position.time, joint.effort, joint.vel.time, joint.vel.signal,'static')
% 
% % Filter signal to define friction x vel point
% [friction, vel] = signal_filter(interval, joint);

friction = friction_joint;
vel = vel_joint;

%% ------------------------------------------Optimization 
%% Setup
%Param settings
%[Fc Fs Vs Sigma 2]
lower_bound = [0.35 0.35 0.001 0.1];
upper_bound = [1 1 1 100];
barrier_selector = 1;
popSize = 100;

% Prepare functions
fcost = @(x) getCost(x, vel, friction);
fconstraint = @(cx) fun_constraint(cx, upper_bound, lower_bound);
fbarrier = @(gx) fun_barrier(gx, barrier_selector);

% Set seed for repeatability
rng('default');

%% Run PSO algorithm
otim = static_optim(fcost, fconstraint, fbarrier, upper_bound, lower_bound, popSize);

%% Compare friction curves (real x optim)
% Sample number
N = 100;
% Create fake velocity
vel_optim = linspace(0,vel(end),N);
% Plot ideal friction curve obtained from optimized fricion parameters
X = otim;
friction_optim = (X(:,1) + (X(:,2)-X(:,1)) .* exp(-( (1 ./ X(:,3)) * vel_optim' ).^2)) .* sign(vel_optim)' + X(:,4) * vel_optim';

fig = figure();
title(joint_name);
hold on
%subplot(2,1,1);
plot(vel, friction,'r*');
%subplot(2,1,2);
plot(vel_optim, friction_optim);
xlabel('Velocity(rad/s)');
ylabel('Friction(N.m)'); 
hold off