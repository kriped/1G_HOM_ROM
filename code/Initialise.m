clc; clear; close all;
ni = 1; ne= 20; n= ne-ni+1;
solution1_ct = struct('time', cell(1, n), 'state_values', cell(1, n));
load 'input\ROM_input.mat' sigmaX sigmaE XS_HOMO gammaI gammaX lambdaI lambdaX keff bsq nu v drdp kappa EMI phi0mat X0mat
Pi=0.01; Ii = 0; Xi= 0 ; % The main mode is exited with a 1 increase in flux%
P1= 0.0; P2=0;
I1= 0; I2=0;
X1=0; X2 =0; % No other modes are exited


t0 = 0; tf = 3; %time in seconds
tspan = [t0, tf];
bsq0=bsq(1); 
opts=odeset("MaxStep",0.0001); % Options for solver
[maxvals,idxs] = maxk(phi0mat,3,1);
for i = ni:ne
    tic
    %initialise problem
    %Find important cross term modes
    %ls = find(phi0mat(:,i)>1E10)';
    %Get Cross terms coefficeint values for those modes    
    % Sort index values so mode i comes first
    ls = idxs(:,i);
    idx = find(ls==i);
    ls(idx) = ls(1);
    ls(1) = i;
    bsqmn= bsq(ls);
    phi0mn = phi0mat(ls,ls);
    X0mn = X0mat(ls,ls);
    
    IC = [Pi,Ii,Xi,P1,I1,X1,P2,I2,X2]; % Initial conditions vector
    IC = IC(1:(length(ls)*3)); % Trim IC vector to fit number of cross terms
    [time,state_values] = ODE_feedback(bsqmn,bsq0,sigmaX, sigmaE, XS_HOMO, gammaI, gammaX, lambdaI, lambdaX,...
        keff, nu, v, drdp, kappa, EMI,IC,tspan,opts,"ode15s",phi0mn,X0mn);
    solution1_ct(i-ni+1).time=time;
    solution1_ct(i-ni+1).state_values=state_values;
    time = time/3600;
    hold on
    figure(i);
    p=plot(time,state_values(:,:));
    if(length(ls)==1)
    legend("P_i","I_i","X_i")
    elseif(length(ls)==1)
        legend("P_i","I_i","X_i","P_(cs1)","I_(cs1)","X_(cs1)")
    else 
        legend("P_i","I_i","X_i","P_cs1","I_cs1","X_cs1","P_cs2","I_cs2","X_cs2")
    end
    xlabel("Time(h)")
    axis on
    p(1).LineWidth  = 2;
    p(2).LineWidth  = 2;
    p(3).LineWidth  = 2;
    P(2).LineColor = [0.6350 0.0780 0.1840];
    toc
    
end
save("Results\initialise_ct.mat")