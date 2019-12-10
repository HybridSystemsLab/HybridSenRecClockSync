function xdot = f(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: f_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
% Description: Flow map
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00
    
    global mflag2 mag

    M_m = [ x(6); x(7); x(8); x(9); x(10); x(11);];
    M_s = [x(12); x(13); x(14); x(15); x(16); x(17);];
    
    
    xdot = [x(19) + mflag2*normrnd(0,mag); x(20) + mflag2*normrnd(0,mag); -1; 0; 0; zeros(6)*M_m; zeros(6)*M_s; 0; 0; 0; 0; -1];
    
end