function [value] = C(x) 
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: C_Q2.m
%--------------------------------------------------------------------------
% Description: Flow set
% Return 0 if outside of C, and 1 if inside C
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

%x0 = [tauP0; tauO0; tauT0; tauM0; tauS0; q0; M_m0; M_s0];

    tauM = x(3);

    %global T2
    
    if (tauM > 0)
        value = 1;
    else
        value = 0;
    end


end