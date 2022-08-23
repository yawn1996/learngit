function NewTon4(func,x0,y_obj,N,eps)
% 将NewTon3的参数函数输入改为非句柄函数传入，即将符号表达式转变为句柄函数
% 给定 x0:初值；y_obj:目标值；N:最大迭代次数；eps：最大误差
% 缺点：只能找到一个目标值x，比如sin(x)=0.5
% 函数句柄传入参数func,func的数据类型为sym
y_handle = func_handle(func);%转化为句柄函数
var = functions(y_handle).function(3);%寻找自变量
syms x
y = @(x)subs(func,var,x);%改变外自变量为默认自变量x
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

function y_handle = func_handle(external_function)
% 将外部函数形如y = f(x)转化为句柄函数
var = symvar(external_function);
stringformat = '@(%s)';
y_handle = eval([sprintf(stringformat,var) vectorize(external_function)]);
% 网上查的固定写法
% vectorize的目的是将字符串(string)表达式里的* / ^替换为.* ./ .^，以支持向量运算
% eval(expression)
% expression 为字符向量和字符串标量是要计算的表达式

function dy = dfunc(func)
syms y(x)
y(x) = diff(func,x);
dy = @(x)y(x);