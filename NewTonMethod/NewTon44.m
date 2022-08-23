function NewTon44()
clear
clc
eps = 1.0e-6;%横纵坐标最大允许误差
N = 10e3;%最大循环次数
V0 = input('请给定初始值:');
% 开始定义函数方程...
syms V
a = 945225.514; b = 53.482;
T = 400;R = 8.314;P_obj = 1.0;
P = R*T/(V-b)-a/(V^2+2*b*V-b^2);
fplot(P);
% 开始使用牛顿迭代法求解目标值x*
NewTon4(P,V0,P_obj,N,eps);