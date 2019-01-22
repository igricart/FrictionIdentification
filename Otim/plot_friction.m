function plot_friction(X,dx)
Fc = X(1);
Fs = X(2);
Vs = X(3);
sigma2 = X(4);

friction_plot = (Fc + (Fs-Fc).*exp(-(dx./Vs).^2)).*sign(dx) + sigma2.*dx;
plot(dx,friction_plot);
end