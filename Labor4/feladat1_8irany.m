clear all;
close all;
clc;

fun = @(x) x(1)^2 + x(2)^2 + x(1)*x(2) + 2 * x(1);
x = -10 : 0.1 : 10;
y = -10 : 0.1 : 10;
[xr, yr] = meshgrid(x, y);

figure(1);
contour(xr, yr, xr.^2 + yr.^2 + xr.*yr + 2.*xr);

[x0, y0] = ginput(1);
hold on;
plot(x0, y0, 'r*');


currPos = [x0; y0];
I = [1 1 0 -1 -1 -1 0 1; 0 1 1 1 0 -1 -1 -1]; % 8 direction matrix
L = 0.5;
MaxIter = 1000;
tempFvals = [0, 0, 0, 0, 0, 0, 0, 0];
allCords = [currPos(1), currPos(2), fun(currPos)];

for i = 1 : MaxIter

    for j = 1 : 8
       temp = currPos + L * I(:, j);
       tempCords(j, 1) = temp(1);
       tempCords(j, 2) = temp(2);
       tempFvals(j) = fun([tempCords(j, 1), tempCords(j, 2)]);
    end
    
    minFvalPos = 1;
    
    for k = 2 : 8
        if tempFvals(k) < tempFvals(minFvalPos)
           minFvalPos = k; 
        end
    end
    
    plot(tempCords(minFvalPos, 1), tempCords(minFvalPos, 2), '.g');
    currPos = [tempCords(minFvalPos, 1); tempCords(minFvalPos, 2)];
    allCords = [allCords; currPos(1), currPos(2), fun(currPos)];
end

%plot(allCords(:, 1), allCords(:, 2));

figure(2);
mesh(xr, yr, xr.^2 + yr.^2 + xr.*yr + 2.*xr);
hold on;
plot3(allCords(1, 1), allCords(1, 2), allCords(1, 3), '*g');
plot3(allCords(:, 1), allCords(:, 2), allCords(:, 3), '-y');
plot3(allCords(size(allCords, 1), 1), allCords(size(allCords, 1), 2), allCords(size(allCords, 1), 3), '*r')