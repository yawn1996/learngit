function NewTon33()
clear
clc
eps = 1.0e-6;%������������������
N = 10e3;%���ѭ������
V0 = input('�������ʼֵ:');
% V0 = 2800;
% ���庯������
syms V P
a = 945225.514; b = 53.482;
T = 400;R = 8.314;P_obj = 1.0;
P = @(V)R*T/(V-b)-a/(V^2+2*b*V-b^2);
fplot(P(V));
% ʹ��ţ�ٵ��������x*
NewTon3(P(V),V0,P_obj,N,eps);
