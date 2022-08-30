clc; clear; close all;
load("Results\initialise_ct.mat");
bsq0 = bsq(1);
solution2_ct = struct('time', cell(1, n), 'state_values', cell(1, n));
t0 = solution1_ct(1).time(end); % Time starts from end of last simulation
opts=odeset("MaxStep",10);
[maxvals,idxs] = maxk(phi0mat,3,1);
for i = ni:ne
    tic
    if i<3
        tf=1*3600; % if exponential increase sample for 1 hour
    elseif i<5
        tf = 5*3600; % Lesser exponential run for 5 hours
    else
        tf = 100*3600; %if else sample for 100 hours
    end
    tspan = [t0, tf]; % Time span
    IC = solution1_ct(i).state_values(end,:); % Initial conditions from previous solution
   %Find important cross terms
    %ls = find(phi0mat(:,i)>1E10);
    ls = idxs(:,i);
    % Sort index values so mode i comes first
    idx = find(ls==i);
    ls(idx) = ls(1);
    ls(1) = i;
    bsqmn= bsq(ls);
    phi0mn = phi0mat(ls,ls);
    X0mn = X0mat(ls,ls);
    
    IC = IC(1:(length(ls)*3)); % Trim IC vector to fit number of cross terms
    [time,state_values] = ODE_feedback(bsqmn,bsq0,sigmaX, sigmaE, XS_HOMO, gammaI, gammaX, lambdaI, lambdaX,...
        keff, nu, v, drdp, kappa, EMI,IC,tspan,opts,"ode15s",phi0mn,X0mn);
    solution2_ct(i-ni+1).time=time;
    solution2_ct(i-ni+1).state_values=state_values;
    time = time/3600;
    hold on
    figure(i);
    p=plot(time,state_values(:,:));
    if(length(ls)==1)
    legend("P_i","I_i","X_i")
    elseif(length(ls)==1)
        legend("P_i","I_i","X_i","P_(ct1)","I_(ct1)","X_(ct1)")
    else 
        legend("P_i","I_i","X_i","P_{ct1}","I_{ct1}","X_{ct1}","P_{ct2}","I_{ct2}","X_{ct2}")
    end
    xlabel("Time(h)")
    axis on
    p(1).LineWidth  = 2;
    p(2).LineWidth  = 2;
    p(3).LineWidth  = 2;
    P(2).LineColor = [0.6350 0.0780 0.1840];
    toc
end
save("Results\solutions_short_ct.mat")