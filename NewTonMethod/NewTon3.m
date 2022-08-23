function NewTon3(func,x0,y_obj,N,eps)
% Version 3.0 ţ�ٵ�����
% funcΪ�������
% ���� x0:��ֵ��y_obj:Ŀ��ֵ��N:������������eps��������
% ȱ�㣺ֻ���ҵ�һ��Ŀ��ֵx������sin(x)=0.5
% For example: NewTon3(P(V),V0,P_obj,N,eps);
syms x
y = func();%�����Ǿ������������Ҫ����y(num)
var = symvar(y);%Ѱ���Ա���
y = @(x)subs(y,var,x);%�ı����Ա���ΪĬ���Ա���x
dy = dfunc(y);%������Ϊ������������Ե���dy(num)
deltax = 1e16;deltay = 1e16;%������ʼֵ��������
n = 0;%��ʼѭ������
if n<N
    while deltax>eps || deltay>eps
        n = n+1;
        Y = double(y(x0));dY = double(dy(x0));
        x1 = x0+(y_obj-Y)/dY; deltax = abs(x1-x0);
        x0 = x1; deltay = abs(y_obj-Y);
        fprintf('���ڽ��е�%d��ѭ������......\n',n)
        fprintf('����Ŀ��ֵX = %8.7f,Y = %8.7f��\n',x0,Y);
        fprintf('���ֵΪerrX = %8.7f,errY = %8.7f\n',deltax,deltay);
    end
    fprintf('ѭ��������\n')
else
    fprintf('������������������ֹͣ���㣬�����������ֵx0')
end
function dy = dfunc(func)
syms y(x)
y(x) = diff(func,x);
dy = @(x)y(x);