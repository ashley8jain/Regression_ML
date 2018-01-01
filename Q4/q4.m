clear;clc;
X = importdata('q4x.dat');
Y = importdata('q4y.dat');


y_pos = strcmp(Y,'Canada');
y_neg = strcmp(Y,'Alaska');



%%%%%%%%%%%%%%%%  mu0,mu1,cov  %%%%%%%%%%%%%%%%%%%%%%%
mu1 = (sum(X(y_pos,:))./sum(y_pos))';
mu0 = (sum(X(y_neg,:))./sum(y_neg))';

m = size(Y,1);
n = size(X,2);
cov = zeros(n,n);
for i=1:m
    mu = mu1.*y_pos(i)+mu0.*y_neg(i);
    xu = (X(i,:))'-mu;
	cov = cov + xu*xu';
end;
cov = cov./m;

disp('mu0 =');disp(mu0);
disp('mu1 =');disp(mu1);
disp('cov =');disp(cov);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%% plotting %%%%%%%%%%%%%
disp('Press Enter to Display Linear Boundary');
pause;
figure
plot(X(y_neg,1),X(y_neg,2),'o',X(y_pos,1),X(y_pos,2),'x');
xlabel('Fresh water');
ylabel('Marine water');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









%%%%%%%%%%%%%%%%  Decision Boundary1  %%%%%%%%%%%%%%%%%%%%%%%
phi = sum(y_pos)/m;

syms X0 X1;
XX = [X0;X1];
X1 = solve(log((1-phi)/phi)+0.5*((XX-mu1)'*(pinv(cov))*(XX-mu1)-(XX-mu0)'*pinv(cov)*(XX-mu0)),X1);
X0 = (min(X(:,1)):0.5:max(X(:,1)));

hold on;
plot(X0,eval(X1),'r-');
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








%%%%%%%%%%%%%%%%  mu0,mu1,cov0,cov1  %%%%%%%%%%%%%%%%%%%%%%%
cov0 = zeros(n,n);
for i=1:m
    xu = (X(i,:))'-mu0;
	cov0 = cov0 + xu*xu'.*(y_neg(i));
end;
cov0 = cov0./sum(y_neg);



cov1 = zeros(n,n);
for i=1:m
    xu = (X(i,:))'-mu1;
	cov1 = cov1 + xu*xu'.*(y_pos(i));
end;
cov1 = cov1./sum(y_pos);



disp('mu0 =');disp(mu0);
disp('mu1 =');disp(mu1);
disp('cov0 =');disp(cov0);
disp('cov1 =');disp(cov1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%










%%%%%%%%%%%%%%%%  Decision Boundary2  %%%%%%%%%%%%%%%%%%%%%%%

disp('Press Enter to Display Quadratic Boundary');
pause;
syms X0 X1;
XX = [X0;X1];

X1 = solve(log(((1-phi)*sqrt(det(cov1)))/(phi*sqrt(det(cov0))))+0.5*(((transpose(XX-mu1))*(pinv(cov1))*(XX-mu1))-((transpose(XX-mu0))*(pinv(cov0))*(XX-mu0))),X1);
X0 = (min(X(:,1)):0.5:max(X(:,1)));

hold on;
plot(X0,eval(X1(2)),'g-');
legend('Alaska','Canada','Linear DB','Quadratic DB');
title('GDA');
hold off;
disp('--- end ---');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%