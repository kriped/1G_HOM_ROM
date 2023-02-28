function [Mode,Bsq] = HOMO_Reactor_MODE_radial(n,m,ii,r,h,ncells) 
% Create cartesian space

% cellarea = r^2/ncells^2;
% cellheight = h/ncells;
% cellvol = cellarea*cellheight;

% x = zeros(1,ncells);
% y = zeros(1,ncells);
% for i = 1:ncells
%     x(i) = sqrt(i*cellarea/pi);
%     y(i) = x(i);
% end
x = linspace(-r,r,2*ncells)';
y = linspace(-r,r,2*ncells)';
z=linspace(-h/2,h/2,ncells)';


%Create meshgrid of cartisian coordinates
[X,Y,Z] = meshgrid(x,y,z);
[t,rad,Z] = cart2pol(X,Y,Z);
%Convert cartesian coordinates to polar
% rad = sqrt(X.^2+Y.^2);
% t = atan(Y./X);
%[t,rad,Z] = meshgrid(t,rad,z);

% remove points outside the core
rad(rad>r) = nan;

%Calculate Axial function
if n==0
    kappa = pi/h;
    axialf = cos(kappa.*Z);
elseif mod(n,2) == 0
    kappa = (2*ceil(n/2)+1)*pi/h;
    axialf = cos(kappa.*Z);
else
    kappa = 2*ceil(n/2)*pi/h;
    axialf = sin(kappa.*Z);
end


% Create polar function

if m==0
    guess = 2.5505 + 1.2474*m+ii*pi;
    besselzero = fzero(@(q) besselj(m, q),guess);
    a = besselzero/r;
    radial = besselj(ceil(m/2),a*rad);
    azi = ones(1,length(t));
elseif mod(m,2) == 1
    guess = 2.5505 + 1.2474*ceil(m/2)+ii*pi;
    besselzero = fzero(@(q) besselj(ceil(m/2), q),guess);
    a = besselzero/r; 
    radial = besselj(ceil(m/2),a*rad);
    azi = cos(ceil(m/2)*t);    
else 
    guess = 2.5505 + 1.2474*ceil(m/2)+ii*pi;
    besselzero = fzero(@(q) besselj(ceil(m/2), q),guess);
    a = besselzero/r;   
    radial = besselj(ceil(m/2),a*rad); 
    azi = sin(ceil(m/2)*t);
end

%Finished mode
Mode = axialf.*radial.*azi;
Mode(isnan(Mode)) = 0;
Bsq = a^2 + kappa^2;
end