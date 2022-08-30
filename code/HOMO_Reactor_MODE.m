function [Mode,Bsq] = HOMO_Reactor_MODE(n,m,ii,r,h) 

x=linspace(-h/2,h/2,75);
rho = linspace(0,r,75);
theta = linspace(0,2*pi,75);
[z,rad,t] = meshgrid(x,rho,theta);
if n==0
    kappa = pi/h;
    axialf = cos(kappa.*z);
elseif mod(n,2) == 0
    kappa = (2*ceil(n/2)+1)*pi/h;
    axialf = cos(kappa.*z);
else
    kappa = 2*ceil(n/2)*pi/h;
    axialf = sin(kappa.*z);
end


% Create polar data

if m==0
    guess = 2.5505 + 1.2474*m+ii*pi;
    besselzero = fzero(@(z) besselj(m, z),guess);
    a = besselzero/r;
    radial = besselj(ceil(m/2),a*rad);
    azi = 1;
elseif mod(m,2) == 1
    guess = 2.5505 + 1.2474*ceil(m/2)+ii*pi;
    besselzero = fzero(@(z) besselj(ceil(m/2), z),guess);
    a = besselzero/r; 
    radial = besselj(ceil(m/2),a*rad);
    azi = cos(ceil(m/2)*t);    
else 
    guess = 2.5505 + 1.2474*ceil(m/2)+ii*pi;
    besselzero = fzero(@(z) besselj(ceil(m/2), z),guess);
    a = besselzero/r;   
    radial = besselj(ceil(m/2),a*rad); 
    azi = sin(ceil(m/2)*t);
end
Mode = axialf.*radial.*azi;
Bsq = a^2 + kappa^2;
end