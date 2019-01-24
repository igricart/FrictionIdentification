%%  Script to test PSO algorithm
%   Barrier Selector: 1 - Discontinuous, Otherwise - No barrier
%   

% Load data
log = load('log_Fr_ss_p_19-Jan-23-15-27-07.mat');
data = log;

% Param settings
lower_bound = [1 1 0.001 0.1];
upper_bound = [10 10 1 100];
barrier_selector = 1;

% Prepare functions
fcost = @(x) getCost(x, data);
fconstraint = @(cx) fun_constraint(cx, upper_bound, lower_bound);
fbarrier = @(gx) fun_barrier(gx, barrier_selector);

% Set seed for repeatability
rng('default');

% Run PSO algorithm
otim = Static_Identif(fcost, fconstraint, fbarrier, upper_bound, lower_bound);
