cvx_clear

global c d mu

Af = [0 1; 0 0];

n = length(Af);

N = 5;


K = .3;

v = [0,0.5];

Ag = eye(2) + [-1 0.5*(3*c + 4*d); 0 -mu*(2*(c + d))];



A1low = expm(Af*v(1))*Ag;
A1high = expm(Af*v(2))*Ag;
eigA1high = max(abs(eig(A1high)));
eigA1low = max(abs(eig(A1low)));

if eigA1high > 1
    error('eigA1high > 1')
end

cvx_begin sdp 
    variable P1(size(Af)) symmetric 
    variable Q1(size(Ag)) symmetric
    A1high'*P1*A1high - P1 <= -.1*Q1;
    A1low'*P1*A1low - P1 <= -.1*Q1;
    P1 >= eye(size(Ag));
    Q1 >= eye(size(Ag));
cvx_end