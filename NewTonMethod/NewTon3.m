function NewTon3(func,x0,y_obj,N,eps)
% Version 3.0 牛顿迭代法
% func为句柄函数
% 给定 x0:初值；y_obj:目标值；N:最大迭代次数；eps：最大误差
% 缺点：只能找到一个目标值x，比如sin(x)=0.5
% For example: NewTon3(P(V),V0,P_obj,N,eps);
syms x
y = func();%必须是句柄函数，后面要调用y(num)
var = symvar(y);%寻找自变量
y = @(x)subs(y,var,x);%改变外自变量为默认自变量x
dy = dfunc(y);%导函数为句柄函数，可以调用dy(num)
deltax = 1e16;deltay = 1e16;%给定初始值启动计算
n = 0;%初始循环次数
if n<N
    while deltax>eps || deltay>eps
        n = n+1;
        Y = double(y(x0));dY = double(dy(x0));
        x1 = x0+(y_obj-Y)/dY; deltax = abs(x1-x0);
        x0 = x1; deltay = abs(y_obj-Y);
        fprintf('正在进行第%d次循环计算......\n',n)
        fprintf('计算目标值X = %8.7f,Y = %8.7f，\n',x0,Y);
        fprintf('误差值为errX = %8.7f,errY = %8.7f\n',deltax,deltay);
    end
    fprintf('循环结束！\n')
else
    fprintf('超过最大迭代次数，已停止计算，请重新输入初值x0')
end
function dy = dfunc(func)
syms y(x)
y(x) = diff(func,x);
dy = @(x)y(x);