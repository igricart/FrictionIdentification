%% Obtain data from friction_Pcontrol.slx

x = SDOSimTest_Log.x.signals.values;
dx = SDOSimTest_Log.dx.signals.values;
ddx = SDOSimTest_Log.ddx.signals.values;
u = SDOSimTest_Log.input_signal.signals.values;
t = SDOSimTest_Log.x.time;

% Discard first half simulation time
N = round(length(x) / 2);
x = x(N:end);
dx = dx(N:end);
ddx = ddx(N:end);
u = u(N:end);
t = t(N:end);
t = t - t(1);

% % Create struct
data.x = x;
data.dx = dx;
data.ddx = ddx;
data.u = u;
data.t = t;