function [effort_mean, speed_mean] = signal_filter(interval, joint)

n_points = size(interval,1);
%% Loop to find index from effort_time and speed_time

for idx = 1 : n_points
    [i(idx),j(idx),k(idx),l(idx)] = find_interval(interval(idx,1), interval(idx,2), joint.position.time, joint.vel.time);
    effort_mean(idx) = mean(joint.effort(i(idx):j(idx)));
    speed_mean(idx) = mean(joint.vel.signal(k(idx):l(idx)));
end