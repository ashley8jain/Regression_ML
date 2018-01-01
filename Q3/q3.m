clear;clc;
X = importdata('q2x.dat');
y = importdata('q2y.dat');
%including intercept term in X
X_new = [ones(1,size(X,1));X']';




%%%%%%%%%%%%%  computing theta using Newton Method %%%%%%%%%%%%%%%
m = size(X_new,1);
n = size(X_new,2);
theta = zeros(n, 1);

h = sigmoid(X_new*theta);
J1 = 1;
dJ = 1;
iters=0;
while abs(dJ)>0.00001
    gradtheta = ((y-h)'*X_new)';
    gradtheta = gradtheta./m;
    H = zeros(n, n);
    
    for i=1:m
        theta_X = X_new(i,:)*theta;
        H = H - sigmoid(theta_X)*(1-sigmoid(theta_X))*(X_new(i,:))'*X_new(i,:);
    end    
    H = H./m;
	theta = theta - pinv(H)*gradtheta;
    J2 = sum(y.*log(h) + (1 - y).*log(1-h));
    dJ = J2-J1;
    J1 = J2;
    h = sigmoid(X_new*theta);
    iters=iters+1;
end
disp('#iterations=');disp(iters);
disp('Hessian= ');disp(H);
disp('Final theta=');disp(theta);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%  plotting %%%%%%%%%%%%%%%
disp('press enter to display decision boundary');
pause;
y_pos = y==1;
y_neg = y==0;

%decision boundary
X2 = min(X_new(:,2)):0.1:max(X_new(:,2));
Y2 = (-theta(1)-theta(2)*X2)/(theta(3));
figure
plot(X(y_neg,1),X(y_neg,2),'o',X(y_pos,1),X(y_pos,2),'x',X2,Y2,'r-');

xlabel('X1');
ylabel('X2');
legend('0','1','Decision Boundary');
title('Newtons method');
disp('--- end ---');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%