function cost = getCost(X, dx, u)
    N_pop = size(X, 1);
    N_data = length(dx);
    friction = (X(:,1) + ...
        (X(:,2)-X(:,1)) .* exp(-( (1 ./ X(:,3)) * dx ).^2)) .* sign(dx) + ...
        X(:,4) * dx;
    cost = sum( (u - friction).^2, 2) / length(u);
end