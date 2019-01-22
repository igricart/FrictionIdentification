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
vs = 0.01;%(m/s)
i = 2;%

%% Model 5 - Dahl Model

%Fc = 3;%(N)
sigma0 = 1e5;%(N/m)

%% Model 6 - LuGre
Fc = 0.41;
Fs = 0.7;
%i = 6.7;
sigma1 = sqrt(1e5);
sigma2 = 0.4;

% Kermani paper parameters
Fc = 2;
Fs = 3;
i = 2;
sigma0 = 1000;
sigma1 = 200;
sigma2 = 1;

%% Model parameters
mass = 3.14;

%% Control parameters
ctrl_ts = 1e-3;
daq_ts = 1e-3;
ctrl_mass = mass;