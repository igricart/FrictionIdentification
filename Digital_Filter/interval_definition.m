%% Define intervals for parameter identification
% Input must be given for a certain joint
% Ex.: interval = interval_definition(data.yaw)

function interval = interval_definition(time1, data1,time2, data2, exp)
    % Initial plots
    window = figure(1);
    %set(window, 'WindowStyle', 'Docked');
    ax1 = subplot(2,1,1);
    plot(time1, data1, '--');
    grid(ax1,'on');
    grid minor;
    if (exp == "static")
        legend('Effort');
        ylabel('Effort(N.m)')
    elseif (exp == "dynamic")
        legend('Joint Position');
        ylabel('Angle(rad)')
    end
    xlabel('time(s)');
    ax2 = subplot(2,1,2);
    plot(time2, data2, '--');
    grid(ax2,'on')
    grid minor;
    if (exp == "static")
        legend('Velocity');
        ylabel('Reference signal(rad/s)')
    elseif (exp == "dynamic")
        legend('Effort');
        ylabel('Reference signal(N.m)')
    end
    xlabel('time(s)');
    set(window, 'WindowStyle', 'Docked');
    
    % Define interval
    interval = input('Choose intervals separeting as [t_init1, t_final1; t_init2, t_final2] \n');
    line = size(interval,1);
    for i = 1 : line
        resp = 'n';
        while ~isempty(resp)
            ax1 = subplot(2,1,1);
            grid(ax1,'on');
            xlim([interval(i,:)])
            ax2 = subplot(2,1,2);
            grid(ax2,'on');
            xlim([interval(i,:)])
            X = sprintf('Data from interval %d',i);
            disp(X);
            resp = input('Good enough? Press ENTER to proceed to next interval otherwise choose new interval \n');
            if ~isempty(resp)
                if size(resp,2) == 2
                    interval(i,:) = resp;
                else
                    warning('Input must be similar to [x y]')
            end           
       end
    end
end