%%% Script for friction models tests
% HEADS project

%% Model 1 - Coulomb Friction
% Needs mu, Fn and Fapp
% mu = Coulomb Friction coeficient
% Fn = Normal load between two surfaces
% Fapp = Force applied (has to be lass than mu*Fn)
% F = mu * Fn * sign(dx)

%% Model 2 - Viscous Friction model
% kv = viscous coefficient
% F = kv * dx

%% Model 3 - Integrated Coulomb and Viscous model

%% Model 4 - Stribeck model
kv = 1;%(N/m)
vs = 0.001;%(m/s)
i = 2;%

%% Model 5 - Dahl Model

%Fc = 3;%(N)
sigma0 = 1e5;%(N/m)

%% Model 6 - LuGre
Fc = 0.58;
Fs = 1;
%i = 6.7;
sigma1 = 240000;
sigma2 = 15000;

% Kermani paper parameters
Fc = 0.58;
Fs = 1;
i = 2;
sigma0 = 2000;%240000;
sigma1 = 1000;%15000;
sigma2 = 1.295;

%% Model parameters
mass = 4.1691;

%% Control parameters
ctrl_ts = 1e-3;
daq_ts = 1e-3;
ctrl_mass = mass;

%% Simulation parameters
ts_buffer_stop = ctrl_ts;
%tol_ss = ref_angle*5e-3;

% Variables Initialized but that will be replaced in other scripts
ref_angle = 0.05;
tol_ss = ref_angle*5e-3;
ctrl_selector = 2; %Velocity