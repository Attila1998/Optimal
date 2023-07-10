clear all;
close all;
clc;

fun = @(x) x(1).*exp(-x(1).^2 - x(2).^2);
x = -10 : 0.1 : 10;
y = -10 : 0.1 : 10;
[xr, yr] = meshgrid(x, y);

figure(1);
contour(xr, yr, xr.*exp(-xr.^2 - yr.^2));

[x0, y0] = ginput(1);
hold on;
plot(x0, y0, 'r*');


currPos = [x0; y0];
I = [1 0 -1 0; 0 1 0 -1]; % 4 direction matrix
L = 0.5;
MaxIter = 1000;
tempFvals = [0, 0, 0, 0];
allCords = [currPos(1), currPos(2), fun(currPos)];
direction = 1;

for i = 1 : MaxIter
    temp = currPos + L * I(:, direction);
    
    if fun(temp) < fun(currPos)
       currPos = temp;
       allCords = [allCords; currPos(1), currPos(2), fun(currPos)];
       plot(currPos(1), currPos(2), '*g');
    else
        direction = mod(direction + 1, 4);
        if direction == 0
            direction = 1;
        end
    end
end

plot(allCords(:, 1), allCords(:, 2));

figure(2);
mesh(xr, yr, xr.*exp(-xr.^2 - yr.^2));
hold on;
plot3(allCords(1, 1), allCords(1, 2), allCords(1, 3), '*g');
plot3(allCords(:, 1), allCords(:, 2), allCords(:, 3), '-b');
plot3(allCords(size(allCords, 1), 1), allCords(size(allCords, 1), 2), allCords(size(allCords, 1), 3), '*r')