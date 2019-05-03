function cost = getCost_full(X, ddx, u, z, z_dot, mass)
    % Estimate sigma0 and sigma1 through 
    friction_est = X(:,1) * z + X(:,2) * z_dot + sigma2 * dx;
    friction_real = u - mass * ddx;
    cost = sum( (friction_est - friction_real).^2, 2) / length(u);
end