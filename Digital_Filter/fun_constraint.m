%% Finds constraint occurrance
% Input: Population  matrix, Upper Bound, Lower Bound
% Return contraint values [-1 1] in the form
% [g1(x1), g2(x1); g1(x2), g2(x2)]

function [constraint_occur,num_constraints] = fun_constraint(X, UB, LB)
    constraint_occur = ...
        [sum(X > UB,2), ...
        sum(X < LB,2), ...
        sum(X(:,1) > X(:,2),2)];
    num_constraints = size(constraint_occur,2);
end