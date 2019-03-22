%% Define intervals for parameter identification
% Input must be given for a certain joint
% Ex.: interval = interval_definition(data.yaw)

function interval = interval_definition(time1, data1,time2, data2)
    % Initial plots
    window = figure(1);
    set(window, 'WindowStyle', 'Docked');
    subplot(2,1,1);
    plot(time1, data1, '--');
    legend('Input1');
    subplot(2,1,2);
    plot(time2, data2, '--');
    legend('Input2');
    
    % Define interval
    interval = input('Choose intervals separeting as [t_init1, t_final1; t_init2, t_final2] \n');
    line = size(interval,1);
    for i = 1 : line
        resp = 'n';
        while ~isempty(resp)
            subplot(2,1,1);
            xlim([interval(i,:)])
            subplot(2,1,2);
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