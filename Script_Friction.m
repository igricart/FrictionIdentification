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
Fc = 3;%(N)
Fapp = Fc/2;
kv = 40.101e-2;%(N/m)
Fs = Fc*1.3;%(N)
vs = 1.6e1;%(m/s)
i = 2;%

%% Model 5 - Dahl Model

%Fc = 3;%(N)
sigma0 = 10e4;%(N/m)

%% Model 6 - LuGre
Fc = 2.4;
Fs = 4.9;
i = 6.7;
sigma1 = 500;
sigma2 = 11.1;

%% Model parameters
mass = 1;

%% Control parameters
ctrl_ts = 1e-3;
daq_ts = 1e-3;
ctrl_mass = mass;