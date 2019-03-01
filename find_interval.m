% Experimental Intervals from effort_time and speed_time after normalizing
% their values by subtracting x_time from the earliest time begin
% ex.: effort_time = yaw_motor_r.joints_state_samples.time - yaw_motor_r.joints_state_samples.time(1);
% 
% Time intervals -> [50.24, 95.78], [193, 220.5], [258.3, 270.5], [291.3, 297.8]

function [idx_init1, idx_final1, idx_init2, idx_final2] = find_interval(t_init, t_final, data1, data2)
    % Find index
    idx_init1 = find(data1 >= t_init, 1);
    idx_final1 = find(data1 >= t_final, 1);
    idx_init2 = find(data2 >= t_init, 1);
    idx_final2 = find(data2 >= t_final, 1);
    
    % Validate interval
    if data1(idx_init1:idx_final1) == data2(idx_init2:idx_final2)
        disp('Time values are the same');
    else
        msg = 'Time values are different from data1 and data2';
        error(msg);
    end
end