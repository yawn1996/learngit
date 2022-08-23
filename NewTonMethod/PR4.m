% J.M Smith
% ������Դ�ڡ�Introduction to Chemical Engineering Thermodynamics�� 
function PR4
clear
clc
format short
% ��� �ٽ��¶�Tc/K �ٽ�ѹ��Pc/MPa ƫ������omega ��ɱ���
R22_11 = [369.2 4.975 0.215 0.5;
    385 4.224 0.176 0.5];
R = 8.31446; % ��λ��MPa��cm3��mol-1��K-1
T = 400; %�¶ȣ���λ��K
P = 1.0; %ѹ������λ��MPa
%% �����a,b
a = funa(R,R22_11,T);
b = funb(R22_11,R);
%% ��V
epsilon = 1-sqrt(2);sigma = 1+sqrt(2);
syms V1 P1
eqn = R*T/(V1-b)-a/((V1+epsilon*b)*(V1+sigma*b)) == P1;
r = solve(eqn, V1);
V = vpa(subs(r,P1,P));
V = V(imag(V)==0);
%V = V(find(imag(V)==0));
fprintf('��ѹ��p = %d Mpaʱ��',P)
fprintf('Ħ�����VmΪ��%8.3f cm^3��mol-1\n',V);

function ya=funa(R,R22_11,T)
% ��Peng-Robinson״̬���̵Ĳ���a
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
k = [0 0;0 0];%�໥���ò���[k11 k12;k21 k22]
aij = ones(2,2);
for i = 1:2
    for j = 1:2
        aij(i,j) = sqrt(aT(i)*aT(j))*(1-k(i,j));
    end
end
% ��Ϲ���
a = 0;
for i = 1:2
    for j = 1:2
        a = a + y(i)*y(j)*aij(i,j);
    end
end
fprintf('PR״̬���̵Ĳ��� a��%8.3f Mpa��cm^6��mol-2\n',a);
ya = a;

function yb = funb(R22_11,R)
% ��PR���̵Ĳ���b
% b = OMEGA*R*Tc/Pc
% OMEGA: pure number, independent of substance but specific to a particular
% equation of state;
OMEGA = 0.07780;
Tc = R22_11(:,1);Pc = R22_11(:,2);y = R22_11(:,4);
bij = Tc./Pc*R*OMEGA;
% ��Ϲ���
b = 0;
for i = 1:2
    b = b + y(i)*bij(i);
end
fprintf('PR״̬���̵Ĳ��� b��%8.3f cm^3��mol-1\n',b);
yb = b;