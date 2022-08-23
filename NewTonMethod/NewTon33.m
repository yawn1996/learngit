function NewTon33()
clear
clc
eps = 1.0e-6;%横纵坐标最大允许误差
N = 10e3;%最大循环次数
V0 = input('请给定初始值:');
% V0 = 2800;
% 定义函数方程
syms V P
a = 945225.514; b = 53.482;
T = 400;R = 8.314;P_obj = 1.0;
P = @(V)R*T/(V-b)-a/(V^2+2*b*V-b^2);
fplot(P(V));
% 使用牛顿迭代法求解x*
NewTon3(P(V),V0,P_obj,N,eps);
