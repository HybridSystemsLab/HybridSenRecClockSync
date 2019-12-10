function xplus = g(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: g_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
% Description: Jump map
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

    % state
    %x0 = [tauP0; tauO0; tauT0; tauM0; tauS0; q0; M_m0; M_s0; p0];
    
    global d c mu mflag1 mag
    
    tauP = x(1);
    tauO = x(2);
    tauM = x(3);
    %tauS = x(4);
    q = x(4);
    p = x(5);
    
    M_m = [ x(6);  x(7);  x(8);  x(9); x(10); x(11);];
    M_s = [x(12); x(13); x(14); x(15); x(16); x(17);]; 
    
    aM = x(19);
    aS = x(20);
    aSdyn = x(21);
    aM_plus = aM;
    aS_plus = aS;
    aSdyn_plus = aSdyn;
    tauF_plus = x(end);
    m = mflag1*normrnd(0,mag);
    
    if tauM <= 0
        % Step 1
        if p == 0
            tauM_plus = (1-q)*(d + m) + q*c;
            q_plus = 1;
            p_plus = p + 1;
            M_m_plus = [tauP; M_m(1); M_m(2); M_m(3); M_m(4); M_m(5)];
            M_s_plus = M_s;
            tauP_plus = tauP;
            tauO_plus = tauO;
        % Step 3
        elseif p == 2
            tauM_plus = (1-q)*(d + m) + q*c;
            q_plus = 1;
            p_plus = p + 1;
            M_m_plus = M_m;
            M_s_plus = [tauO; M_s(1); M_s(2); M_s(3); M_s(4); M_s(5)];
            tauP_plus = tauP;
            tauO_plus = tauO;                
        %Step 5
        elseif p == 4
            tauM_plus = (1-q)*(d + m) + q*c;
            q_plus = 1;
            p_plus = p + 1;
            M_m_plus = [tauP; M_m(1); M_m(2); M_m(3); M_m(4); M_m(5)];
            M_s_plus = M_s;
            tauP_plus = tauP;
            tauO_plus = tauO;
        %Step 2
        elseif p == 1
            tauM_plus = (1-q)*(d + m) + q*c;
            q_plus = 0;
            p_plus = p + 1;
            M_m_plus = M_m;
            M_s_plus = [tauO; M_m(1); M_m(2); M_m(3); M_m(4); M_m(5)];
            tauP_plus = tauP;
            tauO_plus = tauO;
        % Step 4
        elseif p == 3
            tauM_plus = (1-q)*(d + m) + q*c;
            q_plus = 0;
            p_plus = p + 1;
            M_m_plus = [tauP; M_s(1); M_s(2); M_s(3); M_s(4); M_s(5)];
            M_s_plus = M_s;
            tauP_plus = tauP;
            tauO_plus = tauO; 
        % Step 6
        elseif p == 5
            tauM_plus = (1-q)*(d + m) + q*c;
            q_plus = 0;
            p_plus = 0;
            M_m_plus = M_m;
            M_s_plus = [tauO; M_m(1); M_m(2); M_m(3); M_m(4); M_m(5);];
            aSdyn_plus = mu*((M_m(1) - M_m(5)) - (tauO - M_m(4)));
            %aSdyn_plus = mu*(M_m(1) - M_m(5));
            %aSdyn_plus = 0;
            aS_plus = aS + aSdyn_plus;
            tauP_plus = tauP; 
            %tauO_plus = tauO;
            tauO_plus = tauO - (M_m(4)-M_m(5)-M_m(2)+M_m(3))/2;
            tauF_plus = 6*d;
        end
    end


    rho = floor(p/5)*((M_m(4)-M_m(5)-M_m(2)+M_m(3))/2);
    
    xplus = [tauP_plus; tauO_plus; tauM_plus; q_plus; p_plus; M_m_plus; M_s_plus; rho; aM_plus; aS_plus; aSdyn_plus; tauF_plus;];
    
end