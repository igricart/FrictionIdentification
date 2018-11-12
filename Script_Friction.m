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
Fc = 2;%(N)
Fapp = Fc/2;
kv = 40.101e-2;%(N/m)
Fs = Fc*1.3;%(N)
vs = 1.6e2;%(m/s)
i = 2;%

%% Model 5 - Dahl Model

%Fc = 3;%(N)
sigma0 = 160.74;%(N/m)

%% Model 6 - LuGre

sigma1 = 6e-2;
sigma2 = 26e-2;

%% Model parameters
mass = 3.67;

%% Control parameters
ctrl_ts = 1e-3;
daq_ts = 1e-3;
ctrl_mass = mass;