%% Function to calculate a friction model cost function.
% x = [Fc Fs Vs Sigma2 Sigma1 Sigma0]

function J = fun_cost(x, u, dx)
    Fc = x(1);
    Fs = x(2);
    Vs = x(3);
    sigma2 = x(4);
    
    %Friction Model LuGre in steady-state
    fr_ss = (Fc + (Fs-Fc).*exp(-(dx./Vs).^2)).*sign(dx) + sigma2.*dx;
    error = u - fr_ss;
    J = norm(error);
    %J = max ( abs(error) );
end