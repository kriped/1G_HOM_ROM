function [time, state_values] = ODE_NSolve(IC,tspan,opts,m)

load 'C:/Users/kriped/Chalmers/Christophe Demaziere - XEROM/Matlab code/1G_HOM_REAL_MAIN_SC/input/ROM_input.mat' sigmaX sigmaE XS_HOMO gammaI gammaX lambdaI lambdaX keff bsq nu v kappa EMI phi0mat X0mat reactor_power FB_1G

bsqmn = bsq;
bsq0 = bsq(1);
phi0mn = phi0mat;
X0mn = X0mat;
%drdp = -35E-3/reactor_power;

nu = 2.44;
f = FunctionGen(m);

fhandle = eval(['@(t,s)[' f ']']);

[time, state_values] = ode15s(fhandle,tspan,IC,opts);
end

