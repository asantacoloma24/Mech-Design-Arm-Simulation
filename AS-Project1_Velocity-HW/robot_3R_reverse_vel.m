function [t1doti_d, t2doti_d, t3doti_d] = robot_3R_reverse_vel(L1, L2, L3, t1i_d, t2i_d, t3i_d, xpdot, ypdot, gdot_d)

%basic values

%c1 = cosd(t1i_d);
%c12 = cosd(t1i_d + t2i_d);
%c123 = cosd(t1i_d + t2i_d + t3i_d);
%s1 = sind(t1i_d);
%s12 = sind(t1i_d + t2i_d);
%s123 = sind(t1i_d + t2i_d + t3i_d);


t1i_r = t1i_d*pi/180;%convert to radians
t2i_r = t2i_d*pi/180;
t3i_r = t3i_d*pi/180;
gdot_r =gdot_d*pi/180;

c1 = cos(t1i_r);
c12 = cos(t1i_r + t2i_r);
c123 = cos(t1i_r + t2i_r + t3i_r);
s1 = sin(t1i_r);
s12 = sin(t1i_r + t2i_r);
s123 = sin(t1i_r + t2i_r + t3i_r);

%Solution set up
matrix1 = [(-L1*s1-L2*s12-L3*s123), (-L2*s12-L3*s123), (-L3*s123);...
            (L1*c1+L2*c12+L3*c123), (L2*c12+L3*c123), (L3*c123); ...
            (1), (1), (1)]; %3 by 3 matrix

pos_dot = [xpdot; ypdot; gdot_r]; % velocity (dot derivative of position matrix, 3 by 1

invmatrix = inv(matrix1);
%get solution as a matrix
theta_dots = invmatrix * pos_dot; % 3by 3 * 3 by 1 should yield 3 by 1 solution matrix

%solution extracted from matrix
% t1doti_d = theta_dots(1,1);%*180/pi 
% t2doti_d = theta_dots(2,1);%*180/pi
% t3doti_d = theta_dots(3,1);%*180/pi

t1doti_d = theta_dots(1,1)*180/pi;% convert radians back to degrees 
t2doti_d = theta_dots(2,1)*180/pi;
t3doti_d = theta_dots(3,1)*180/pi;

end