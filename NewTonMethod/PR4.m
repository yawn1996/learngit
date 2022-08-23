% J.M Smith
% 方程来源于《Introduction to Chemical Engineering Thermodynamics》 
function PR4
clear
clc
format short
% 组分 临界温度Tc/K 临界压力Pc/MPa 偏心因子omega 组成比例
R22_11 = [369.2 4.975 0.215 0.5;
    385 4.224 0.176 0.5];
R = 8.31446; % 单位：MPa·cm3·mol-1·K-1
T = 400; %温度，单位：K
P = 1.0; %压力，单位：MPa
%% 求参数a,b
a = funa(R,R22_11,T);
b = funb(R22_11,R);
%% 求V
epsilon = 1-sqrt(2);sigma = 1+sqrt(2);
syms V1 P1
eqn = R*T/(V1-b)-a/((V1+epsilon*b)*(V1+sigma*b)) == P1;
r = solve(eqn, V1);
V = vpa(subs(r,P1,P));
V = V(imag(V)==0);
%V = V(find(imag(V)==0));
fprintf('当压力p = %d Mpa时：',P)
fprintf('摩尔体积Vm为：%8.3f cm^3·mol-1\n',V);

function ya=funa(R,R22_11,T)
% 求Peng-Robinson状态方程的参数a
% a(T) = PSI*a(Tr,omega)*R^2*Tc^2/Pc
% a(Tr,omega) = (1+(0.37464+1.54226*omega-0.26992*omega^2)*(1-Tr^0.5))^2;
% PSI: pure number, independent of substance but specific to a particular
% equation of state;
PSI = 0.45724;
Tc = R22_11(:,1);Pc = R22_11(:,2);
omega = R22_11(:,3);y = R22_11(:,4);
Tr = T./Tc;
a_Tr_omega = (1+(0.37464+1.54226*omega-0.26992*omega.^2).*(1-Tr.^0.5)).^2;
aT = a_Tr_omega./Pc.*(Tc.^2)*R^2*PSI;
k = [0 0;0 0];%相互作用参数[k11 k12;k21 k22]
aij = ones(2,2);
for i = 1:2
    for j = 1:2
        aij(i,j) = sqrt(aT(i)*aT(j))*(1-k(i,j));
    end
end
% 混合规则
a = 0;
for i = 1:2
    for j = 1:2
        a = a + y(i)*y(j)*aij(i,j);
    end
end
fprintf('PR状态方程的参数 a：%8.3f Mpa·cm^6·mol-2\n',a);
ya = a;

function yb = funb(R22_11,R)
% 求PR方程的参数b
% b = OMEGA*R*Tc/Pc
% OMEGA: pure number, independent of substance but specific to a particular
% equation of state;
OMEGA = 0.07780;
Tc = R22_11(:,1);Pc = R22_11(:,2);y = R22_11(:,4);
bij = Tc./Pc*R*OMEGA;
% 混合规则
b = 0;
for i = 1:2
    b = b + y(i)*bij(i);
end
fprintf('PR状态方程的参数 b：%8.3f cm^3·mol-1\n',b);
yb = b;