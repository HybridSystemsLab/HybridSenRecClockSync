global d c mu

A = [0 1; 0 0];

lambda = 3;
alpha = 1;

normd = zeros(length(x(:,19)),1);
V2 = zeros(length(x(:,19)),1);
P = [4.2597   -0.0000;   -0.0000   18.4534];
h = 0.1;
%h = 1;
M = zeros(length(x(:,19)),1);
P_a = zeros(length(x(:,19)),1);
P_m = zeros(length(x(:,19)),1);

%fun = @(s) (12*d)./(1 + exp(-0.5*s));
fun = @(s) log(s);

for i = 1:length(x(:,19))
    normd(i) = norm([x(i,19) - x(i,20); x(i,1) - x(i,2)]);
    V2(i) = [x(i,1)-x(i,2); x(i,19)-x(i,20)]'*expm(A'*(x(i,3) + d*(5-x(i,5))))*P*expm(A*(x(i,3) + d*(5-x(i,5))))*[x(i,1)-x(i,2); x(i,19)-x(i,20)];
    
    P_a(i) = floor(x(i,5)/5)*(mu*((x(i,6) - x(i,10)) - (x(i,2) - x(i,9))) - mu*x(i,20)*x(i,3));
    P_m(i) = floor(x(i,5)/5)*((x(i,9)-x(i,10)-x(i,7)+x(i,8))/2);
    
    Q = ((1-x(i,4))*c + x(i,4)*d);
    
    m1S = round((x(i,12) - ( x(i,2) - x(i,20)*(Q - x(i,3)))),3);
    m1M = round(x(i,6) - ( x(i,1) - x(i,19)*(Q - x(i,3))));
    
    m2Sc = round((x(i,13) - ( x(i,2) - x(i,20)*(c + (Q - x(i,3))))),3);
    m2Md = round((x(i,13) - ( x(i,1) - x(i,19)*(d + (Q - x(i,3))))),3);
    m2Sd = round((x(i,7) - ( x(i,2) - x(i,20)*(d + (Q - x(i,3))))),3);
    m2Mc = round((x(i,7) - ( x(i,1) - x(i,19)*(c + (Q - x(i,3))))),3);
    
    m2ScS = round((x(i,7) - ( x(i,2) - x(i,20)*(d + (Q - x(i,3))))),3);
    
    m3S = round((x(i,8) - ( x(i,2) - x(i,20)*(d + c + (Q - x(i,3))))),3);
    m3M = round((x(i,14) - ( x(i,1) - x(i,19)*(d + c + (Q - x(i,3))))),3);
    
    %m4Sc = (x(i,6) - ( x(i,1) - x(i,20)*(2*c + d + (Q - x(i,3)))));
    m4Mc = round((x(i,9) - ( x(i,1) - x(i,19)*(2*d + c + (Q - x(i,3))))),3);
    m4Sc = round((x(i,9) - ( x(i,2) - x(i,20)*(2*c + d + (Q - x(i,3))))),3);
    %m4Md = round((x(i,9) - ( x(i,1) - x(i,19)*(2*d + c + (Q - x(i,3))))),3);
    
    m5S = round((x(i,10) - ( x(i,2) - x(i,20)*(2*d + 2*c + (Q - x(i,3))))),3);
    m5M = round((x(i,10) - ( x(i,1) - x(i,19)*(2*d + 2*c + (Q - x(i,3))))),3);
    
    if(x(i,5) == 0 && (x(i,4) == 0)) % M_1
        M(i) = 1;
    elseif((x(i,5) == 1) && (m1M == 0) && (x(i,4) == 1)) % M_2
        M(i) = 1;
    elseif((x(i,5) == 2) && (m1S == 0) && (m2Md == 0) && (x(i,4) == 0)) % M_3
        M(i) = 1;
    elseif((x(i,5) == 3) && (m1S == 0) && (m2Sc == 0) && (m3M == 0) && (x(i,4) == 1)) % M_4
        M(i) = 1;
    elseif((x(i,5) == 4) && (m1M == 0) && (m2ScS == 0) && (m3S == 0) && (m4Mc == 0) && (x(i,4) == 0)) % M_5
        M(i) = 1;
    elseif((x(i,5) == 5) && (m1M == 0) && (m2Mc == 0) && (m3S == 0) && (m4Sc == 0) && (m5M == 0) && (x(i,4) == 1)) % M_6
        M(i) = 1;
    else
        M(i) = 0;
    end
    
end

bound = alpha*normd.^2;

%%
% plot solution
figure(1) % position
clf
subplot(2,1,1), plotflows(t,j,x(:,1));
grid on
ylabel('$\tau_P$','Interpreter','latex','FontSize',20)
subplot(2,1,2), plotflows(t,j,x(:,2));
grid on
ylabel('$\tau_O$','Interpreter','latex','FontSize',20)

figure(2)
clf
subplot(2,1,1), plotflows(t,j,abs(x(:,1)-x(:,2)));
grid on
ylabel('$| \tau_i - \tau_k |$','Interpreter','latex','FontSize',30)
subplot(2,1,2), plotflows(t,j,abs(x(:,19) - x(:,20)));
grid on
ylim([-0.1 0.3])
ylabel('$| a_i - a_k |$','Interpreter','latex','FontSize',30)
xlabel('$t$','Interpreter','latex','FontSize',30)

figure(3) % position
clf
%plot(t,x(:,18));
%hold on
%plot(t,x(:,19));
%hold on
plot(t,x(:,3));
grid on
%ylabel('$| \tau_P - \tau_O |$','Interpreter','latex','FontSize',20)
xlabel('$t$','Interpreter','latex','FontSize',20)

figure(4) % position
clf
%plot(t,x(:,18));
%hold on
%plot(t,x(:,19));
%hold on
plot(t,(abs(x(:,19) - x(:,20)) + abs(x(:,1) - x(:,2))));
grid on
%ylabel('$| \tau_P - \tau_O |$','Interpreter','latex','FontSize',20)
xlabel('$t$','Interpreter','latex','FontSize',20)

figure(5) % position
clf
%plot(t,x(:,18));
%hold on
%plot(t,x(:,19));
%hold on
plot(t,(0.5*(x(:,19) - x(:,20)).^2 + 0.5*(x(:,1) - x(:,2)).^2));
grid on
%ylabel('$| \tau_P - \tau_O |$','Interpreter','latex','FontSize',20)
xlabel('$t$','Interpreter','latex','FontSize',20)

%%

modificatorF{1} = 'r';
modificatorF{2} = 'LineWidth';
modificatorF{3} = 1.5;
modificatorJ{1} = '--';
modificatorJ{2} = 'LineWidth';
modificatorJ{3} = 1.5;
modificatorJ{4} = 'Marker';
modificatorJ{5} = '.';
modificatorJ{6} = 'MarkerEdgeColor';
modificatorJ{7} = 'r';
modificatorJ{8} = 'MarkerFaceColor';
modificatorJ{9} = 'r';
modificatorJ{10} = 'MarkerSize';
modificatorJ{11} = 1;


figure(6) % position
clf
%plot(t,x(:,18));
%hold on
%plot(t,x(:,19));
%hold on
%plot(t, V);
%hold on
plotHarc(t,j, V2,[],modificatorF,modificatorJ);
%hold on
%plot(t, VdotBound);
%plot(t,(0.5*(x(:,19) - x(:,20)).^2 + 0.5*(x(:,2) - x(:,1)).^2));
grid on
ylabel('$V(x)$','Interpreter','latex','FontSize',30)
xlabel('$t$','Interpreter','latex','FontSize',30)
%%
% M_m = [ x(6);  x(7);  x(8);  x(9); x(10); x(11);];
%(M_m(4)-M_m(5)-M_m(2)+M_m(3))/2
figure(7)
clf
% plot(t,abs((x(:,9)-x(:,10)-x(:,7)+x(:,8))/2));
% hold on
% plot(t,abs(x(:,1)-x(:,2)));
% hold on
%plot(t,x(:,6) - ( x(:,1) - (((1-x(:,4))*d + x(:,4)*c) - x(:,3))));
%plot(t,M(:));
plot(t,P_a(:));
hold on;
plot(t,P_m(:));
%hold on
%plot(t,x(:,5));
grid on
xlabel('$t$','Interpreter','latex','FontSize',20)
ylabel('$\rho_{\delta}$','Interpreter','latex','FontSize',20)