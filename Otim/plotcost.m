% Data acquired from simulation
load('log_cte_Vel.mat');
u = log(100:700,:);
dx = log(100:700,:);

% Empirical values
N = 10;
x_UB = [3 5 1 1000];
x_LB = [1 1 0.001 0];

Fc = linspace(x_LB(1), x_UB(1), N);
Fs = linspace(x_LB(2), x_UB(2), N);
Vs = linspace(x_LB(3), x_UB(3), N);
sigma2 = linspace(x_LB(4), x_UB(4), N);

[X1, X2, X3, X4] = ndgrid(Fc, Fs, Vs, sigma2);

X = fmincon(@(x) fun_cost(x,log(300:750,1),log(300:750,2)),[1.5, 3, 0.005, 20],[],[],[],[],x_LB,x_UB,[],[])


%% Plot
%Loop to create cost function meshgrid
Y = zeros(size(X1));
for i = 1:N
    for j = 1:N
        for k = 1:N
            for l = 1:N
                x = [X1(i,j,k,l) X2(i,j,k,l) X3(i,j,k,l) X4(i,j,k,l)];
                Y(i,j,k,l) = fun_cost(x, u, dx);
            end
        end
    end
end

% hold on;
% surf(X1, X2, Y);
% contour(X1, X2, Y);
% xlabel('amp');
% ylabel('freq');
% grid on;
% hold off;