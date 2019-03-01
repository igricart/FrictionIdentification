function otim = staticParam(interval, joint)

% Number of velocity experiments within log_file
vel_experiments = size(interval,1);

% Time intervals empirically chosen
interval = [50.24, 95.78; 193, 220.5; 258.3, 270.5; 291.3, 297.8];

% Loop to find index from effort_time and speed_time
for idx = 1 : vel_experiments
    [i(idx),j(idx),k(idx),l(idx)] = find_interval(interval(idx,1), interval(idx,2), joint.position.time, joint.vel.time);
    effort_mean(idx) = mean(joint.effort(i(idx):j(idx)));
    speed_mean(idx) = mean(joint.vel.signal(k(idx):l(idx)));
end

data.dx_ss = speed_mean';
data.u_ss = effort_mean';

% Run script from B_test_optimization
B_script_static_optimization
% Sample number
N = 100;
% Create fake velocity
vel_test = linspace(0,speed_mean(end),N);
% Plot ideal friction curve obtained from optimized fricion parameters
X = otim;
friction = (X(:,1) + (X(:,2)-X(:,1)) .* exp(-( (1 ./ X(:,3)) * vel_test' ).^2)) .* sign(vel_test)' + X(:,4) * vel_test';

fig = figure();
subplot(2,1,1)
plot(speed_mean, effort_mean,'*')
subplot(2,1,2)
plot(vel_test, friction)