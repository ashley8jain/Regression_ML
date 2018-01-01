clear;clc;
X = importdata('q1x.dat');
y = importdata('q1y.dat');
m = length(y);

%Normalize
X = X-mean(X);
X = X./std(X);
%including intercept term in X
X = [ones(1,size(X,1));X']';
n = size(X,2);


%%%%%%%%%%  computing theta  %%%%%%%%%%%
epsilon = 0.00001;
alpha = 0.2;
theta = zeros(n, 1);
J1 = J_value(X, y, theta);
dJ = 1;
index=1;
theta_arr = theta;
while abs(dJ)>epsilon
    dtheta = ((X*theta - y)'*X)';
    dtheta = dtheta*(1/m)*alpha;
    theta = theta - dtheta; 
    J2 = J_value(X, y, theta);
    index=index+1;
    theta_arr = [theta_arr theta];
    dJ = J2-J1;
    J1 = J2;
end
disp('Learning rate =');disp(alpha);
disp('Theta = ');disp(theta);  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%%%%%%%%%%  plotting hypothesis fn and datas %%%%%%%%%%%
y1 = y;
y2 = X*theta;

figure();
plot(X(:,2),y1,'.',X(:,2),y2,'-');
xlabel('area');
ylabel('price');
legend('Given Data','hypothesis fn');
title('2D Plot');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp('Press Enter to display 3D mesh');
pause;


%%%%%%%%%%%%%%   plotting 3d mesh   %%%%%%%%%%%%%%

theta_1 = (0:0.1:10);
theta_2 = (0:0.1:10);
[xx,yy] = meshgrid(theta_1,theta_2);
x_i = size(theta_1,2);
y_i = size(theta_2,2);
zz = zeros(y_i,x_i);
for a = 1:x_i
    for b = 1:y_i
        zz(b,a)=J_value(X,y,[xx(b,a);yy(b,a)]);
    end
end 
figure();
mesh(xx,yy,zz);
xlabel('theta1');
ylabel('theta2');
zlabel('J(theta)')
title('3D Mesh');
 disp('No. of iterations=');disp(size(theta_arr,2));
 disp('alpha = ');disp(alpha);
 disp('animating....');
 for i=1:size(theta_arr,2)
     J = J_value(X,y,theta_arr(:,i));
     hold on;
     plot3(theta_arr(1,i),theta_arr(2,i),J,'rx','LineWidth',2);
     pause(0.2);
 end    
disp('done');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp('Press Enter to display Contour Graph');
pause;



%%%%%%%%%%%%%%%   plotting contours   %%%%%%%%%%%%%%%%%

figure(); 
contour(xx,yy,zz);
xlabel('theta1');
ylabel('theta2');
title('Contour');
 disp('animating....');
 for i=1:size(theta_arr,2)
     
     hold on;
     plot(theta_arr(1,i),theta_arr(2,i),'rx');
     hold off;
     pause(0.2);
 end
 disp('Done!');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%   plotting contours with different alpha values  %%%%%%%%%%%%%%%%%
alpha_arr = [0.1,0.5,0.9,1.3,2.1,2.5];
for ii=1:size(alpha_arr,2)
disp('press enter to display contours with alpha=');disp(alpha_arr(ii));
pause;
epsilon = 0.00001;
theta = zeros(n, 1);
J1 = J_value(X, y, theta);
dJ = 1;
index=1;
theta_arr = theta;
while abs(dJ)>epsilon
    dtheta = ((X*theta - y)'*X)';
    dtheta = dtheta*(1/m)*alpha_arr(ii);
    theta = theta - dtheta;
    J2 = J_value(X, y, theta);
    index=index+1;
    theta_arr = [theta_arr theta];
    dJ = J2-J1;
    J1 = J2;
end
disp('No. of iterations=');disp(size(theta_arr,2));
disp('theta=');disp(theta);
figure(); 
contour(xx,yy,zz);
xlabel('theta1');
ylabel('theta2');
title('Contour');
 disp('animating....');
 for i=1:size(theta_arr,2)
     hold on;
     plot(theta_arr(1,i),theta_arr(2,i),'rx');
     hold off;
     pause(0.2);
 end
 disp('Done!');
end
disp('--- end ---');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%