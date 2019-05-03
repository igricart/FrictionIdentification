%% Script to find dynamic parameters from LuGre friction model
%
% Input: X 1 - sigma0, 2 - sigma1, 3 - sigma2
% Input: data - x, dx, ddx, u
% Output: cost from error between (u - M * ddx) and
% sigma0 * q + (sigma1 + sigma2) * dq

function cost = getCost_dynamic(param, x, dx, ddx, u, mass, sigma2)
    friction1 = param(:,1) * x' + (param(:,2) + sigma2) * dx';
    friction2 =  u' - mass * ddx';
    cost = sum( (friction1 - friction2).^2, 2) / length(x);
end