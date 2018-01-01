clear;clc;
X = importdata('q3x.dat');
y = importdata('q3y.dat');
%including intercept term in X
X_new = [ones(1,size(X,1));X']';

%%%%%%%%%%%%%  computing theta using normal equation %%%%%%%%%%%%%%%
theta = pinv(X_new'*X_new)*X_new'*y;
disp('Normal Equation :-');
disp('theta =');disp(theta);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%  plotting %%%%%%%%%%%%%%%
y1 = y;
y2 = X_new*theta;

disp('Press Enter to display Graph');
pause;
figure();
subplot(1,3,1);
plot(X,y1,'.',X,y2,'-');
xlabel('X');
ylabel('Y');
legend('Given Data','hypothesis fn');
title('Normal eqn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%  computing theta using locally weigthed linear regression %%%%%%%%%%%%%%%

[LWRx,LWRy] = LWR(X_new,y,size(X_new,1),size(X_new,2),0.8);
%plotting
subplot(1,3,2);
plot(X_new(:,2),y,'.',LWRx, LWRy,'-')
xlabel('X');
ylabel('Y');
legend('Given Data','hypothesis fn');
title('LWR with t=0.8');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%  computing theta using LWR with different four given tau values %%%%%%%%%%%%%%%

tau_arr = [0.1,0.3,2,10];
subplot(1,3,3);

for i=1:4
    [LWRx,LWRy] = LWR(X_new,y,size(X_new,1),size(X_new,2),tau_arr(i));
    %plotting
    hold on;
    plot(LWRx, LWRy);
    hold off;
end
 
xlabel('X');
ylabel('Y');
legend('0.1','0.3','2','10');
title('LWR with different t values');
disp('All graphs shown in same figure....Please zoom out figure to view graph clearly');
disp('--- end ---');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


