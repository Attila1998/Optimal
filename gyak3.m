clear all;
close all;
clc;
o = optimset();
o = optimset(o,'MaxIter',1000);
o = optimset(o,'TolX',le-8);

if m == 1
    f=@(x)