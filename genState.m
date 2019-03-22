function [pos,vel] = genState(time, acc, p0, v0)
% Generates position and velocity from acceleration input
%
% Parameters
% ----------
% time
%   Time data.
%
% acc
%   Acceleration data.
%
% p0, optional
%   Initial position. Defaults to 0.
%
% v0, optional
%   Initial velocity. Defaults to 0.
%
% Returns
% -------
% pos
%   Position data.
%
% vel
%   Velocity data

    % Initialize optional variables if they are not passed
    if ~exist('p0', 'var'), p0 = 0; end
    if ~exist('v0', 'var'), v0 = 0; end

    % Create integrator
    integ = ss(0, 1, 1, 0);

    % Obtain velocity and position
    vel = lsim(integ, acc, time, v0);
    pos = lsim(integ, vel, time, p0);
end