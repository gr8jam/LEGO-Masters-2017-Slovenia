function test
q1 = [4/sqrt(3) 0 1]';
q1 = [sqrt(3)/2 1.5 1]';
q1 = [2 2 1]';

T = translate(3,2);
R = rotate(pi/4);
mat =  T*R

Q1 = mat * q1

T = translate(3,2);
R = rotz(45);
% R = rotate(pi/2+pi/4);

mat =  T*R
Q1 = mat * Q1

% iR = inv(R)
% iT = inv(T)
end

function R = rotate(theta)
    R = [cos(theta) -sin(theta) 0;
         sin(theta)  cos(theta) 0;
             0           0      1];       
end

function T = translate(tx,ty)
    T = [1 0 tx;
         0 1 ty;
         0 0  1];
%     T = inv(T);
end

