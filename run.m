%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: run_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00
%close all

global d c mu mflag1 mflag2 mag

d = 0.5;
c = 0.2;
mu = 1/(2*(c+d));
beta = ((3*c + 4*d)^2)/8;
mu = mu*0.5;

% Flag to simulate noise on communication
mflag1 = 0;

% Flag to simulate injected noise on clock rate
mflag2 = 0;
mag = 0.1;

% Check Lyapunov Condition
AA = eye(2) + [-1 0.5*(3*c + 4*d); 0 -mu*(2*(c + d))];
norm(eig(AA))

aI0 = 1.1;
aK0 = 0.8;

gamma = ((aI0-aK0)*(c+d) - (2*d - aI0*d - aK0*d))/2;

%Plant and Observer Clocks

tauI0 = 10;
tauK0 = 0;

% Master-Slave Timer
%tauM0 = d*0.5;
tau0 = d;
tauF0 = d*6;

% Slave-Master Timer
%tauS0 = 0;

% Slave Memory Buffer
M_m0 = rand(6,1);

% Master Memory Buffer
M_s0 = M_m0;

% Logic State Variables
q0 = 0;
p0 = 0;

rho0 = 0;

aSdyn0 = 0;

% state initial condition
x0 = [tauI0; tauK0; tau0; q0; p0; M_m0; M_s0; rho0; aI0; aK0; aSdyn0; tauF0;];

% simulation horizon
TSPAN=[0 50];
JSPAN = [0 500];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.01);

% simulate
[t,j,x] = HyEQsolver( @f,@g,@C,@D,...
    x0,TSPAN,JSPAN,rule,options,'ode45');