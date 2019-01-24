%% Sets optimization barrier boundary
% Input: g_x = [g1(x1), g2(x1); g1(x2), g2(x2)] 
% Return barrier function

function barrier = fun_barrier(g_x,mode)
    switch mode
        case 1
            barrier = g_x > 0;
        otherwise
            % no barrier
            barrier = zeros(size(g_x));
    end
end