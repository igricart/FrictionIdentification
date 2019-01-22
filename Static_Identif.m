function otim = Static_Identif()
    %% Static.m
    % Script used to identify LuGre static parameters Fc, Fs, Vs and sigma2
    % using PSO

    %Part1 - The setting of some parameters
    
    PopSize = 100;
    Dim = 4;
    c1 = 2;
    c2 = 2;
    m = 3.14;
    g = 9.8;
    w_start = 0.9;
    w_end = 0.4;
    V_max = [3 3 10 1];
    MaxIter = 4000;
    Iter = 0;
    log = load('log_Fr_ss_p_19-Jan-22-10-17-50.mat');
    data = log;
    lower_bound = [1 1 0.001 0.1]';
    upper_bound = [10 10 1 100]';

    rng('default');
    X = rand(PopSize, Dim) * diag(upper_bound - lower_bound);
    X = X + ones(size(X)) * diag(lower_bound);
    V = rand(PopSize, Dim);
    R1 = rand(MaxIter + 1,1);
    R2 = rand(MaxIter + 1,1);
    
    % Compute population cost
    FX = getCost(X, data);

    % Part 2: Sets the current position as the best one of the particle and records it
    personal_best = X;
    F_best_personal = FX;
    [F_alltime_best, ind_min] = min(FX);
    X_alltime_best = X(ind_min, :);

    %Part 3: LOOP
    while(Iter <= MaxIter)
        Iter = Iter+1;
        w_now = ((w_start - w_end) * (MaxIter - Iter) / MaxIter) + w_end;
        V = w_now * V + c1 * R1(Iter) .* (personal_best - X) + c2 * R2(Iter) .* (X_alltime_best - X);
    %     for i = 1 : PopSize
    %         if V(
    %
    %     end

        ind_change = V > V_max;
        for k = 1:Dim
            V(ind_change(:,k), k) = V_max(k);
        end
        ind_change = V < -V_max;
        for k = 1:Dim
            V(ind_change(:,k), k) = -V_max(k);
        end
        X = X + 1.0 * V;
        
        % Compute population cost
        FX = getCost(X, data);

        % Update personal best
        ind_best_personal = FX < F_best_personal;
        F_best_personal(ind_best_personal) = FX(ind_best_personal);
        personal_best(ind_best_personal,:) = X(ind_best_personal,:);
        
        % Update global all time best
        [min_F_personal_best, ind_min_Fpb] = min(F_best_personal);
        if min_F_personal_best < F_alltime_best
            X_alltime_best = X(ind_min_Fpb, :);
            F_alltime_best = min_F_personal_best;
        end
    end
    Fc_otim = X_alltime_best(1,1),Fs_otim = X_alltime_best(1,2),Vs_otim = X_alltime_best(1,3),sigma2_otim = X_alltime_best(1,4)
    otim = [Fc_otim,Fs_otim,Vs_otim,sigma2_otim];
end

function cost = getCost(X, data)
    N_pop = size(X, 1);
    N_data = length(data.dx_ss);
    friction = (X(:,1) + ...
        (X(:,2)-X(:,1)) .* exp(-( (1 ./ X(:,3)) * data.dx_ss' ).^2)) .* sign(data.dx_ss)' + ...
        X(:,4) * data.dx_ss';
    % Constraints
    
    
    cost = sum( (data.u_ss' - friction).^2, 2) / length(data.u_ss);
end