function J = J_value(X, y, theta)
J = 0;

m = length(y);
J = sum((X*theta - y).^2);
i = 0.5/m;
J = J*i;

end