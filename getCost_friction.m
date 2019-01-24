%% Script to find Sigma parameters from LuGre friction model
%
% Input: X 1 - sigma0, 2 - sigma1, 3 - sigma2
% Input: data - x, dx, ddx, u
% Output: cost from error between (u - M * ddx) and
% sigma0 * q + (sigma1 + sigma2) * dq

function cost = getCost_friction(param, data, mass)
    friction1 = param(:,1) * data.x' + (param(:,2) + param(:,3)) * data.dx';
    friction2 =  data.u' - mass * data.ddx';
    cost = sum( (friction1 - friction2).^2, 2) / length(data.x);
end