function cost = getCost(X, data)
    N_pop = size(X, 1);
    N_data = length(data.dx_ss);
    friction = (X(:,1) + ...
        (X(:,2)-X(:,1)) .* exp(-( (1 ./ X(:,3)) * data.dx_ss' ).^2)) .* sign(data.dx_ss)' + ...
        X(:,4) * data.dx_ss';
    cost = sum( (data.u_ss' - friction).^2, 2) / length(data.u_ss);
end