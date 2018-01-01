function g = sigmoid(z)

g = zeros(size(z));

g = exp(-1.*z)+1;
g = 1./g;

end
