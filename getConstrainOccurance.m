%% Finds constraint occurrance
% Input: Population  matrix, Upper Bound, Lower Bound
% Return contraint values [-1 1] in the form
% [g1(x1), g2(x1); g1(x2), g2(x2)]

function constraint_occur = getConstrainOccurance(X, UB, LB)
    sum(X > UB,2)
    constraint_occur = X > UB || X < LB || X(:,1) > X(:,2);
end