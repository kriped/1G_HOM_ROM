function [time, state_values] = ODE_NSolve(IC,tspan,opts,m)

load 'input\ROM_input.mat' sigmaX sigmaE XS_HOMO gammaI gammaX lambdaI lambdaX keff bsq nu v drdp kappa EMI phi0mat X0mat power

bsqmn = bsq;
bsq0 = bsq(1);
phi0mn = phi0mat;
X0mn = X0mat;
drdp = -35E-3/power;
%drdp = -15e-3/power; 
FB = drdp*(XS_HOMO.SA+XS_HOMO.D*bsq0)*kappa*EMI*XS_HOMO.NF/nu;

f = FunctionGen(m);

fhandle = eval(['@(t,s)[' f ']']);

[time, state_values] = ode15s(fhandle,tspan,IC,opts);
end

