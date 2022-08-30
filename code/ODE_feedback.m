%[Sdot] = g(t,s)
function [time, state_values] = ODE_feedback(bsqmn,bsq0,sigmaX, sigmaE, XS_HOMO, gammaI, gammaX, lambdaI, lambdaX,...
keff, nu, v, drdp, kappa, EMI,IC,tspan,opts,method,phi0mn,X0mn)


% [v] = [ v(1),v(2), v(3)] = [ v1, v2, v3] = [P, I, X]

%Define function

FB = drdp*(XS_HOMO.SA+XS_HOMO.D*bsq0)*kappa*EMI*XS_HOMO.NF/nu;

if length(bsqmn) == 1
    g = @(t,s) [v*((-XS_HOMO.D*bsqmn(1)+sigmaE+FB*phi0mn(1,1))*s(1)-sigmaX*phi0mn(1,1)*s(3)); % Phi
        
        gammaI*XS_HOMO.NF/(nu*keff)*s(1)-lambdaI*s(2); %Iodine
        
        lambdaI*s(2)+(gammaX*XS_HOMO.NF/(keff*nu)-sigmaX*X0mn(1,1))*s(1)-(lambdaX+sigmaX*phi0mn(1,1))*s(3)]; % Xenon

elseif length(bsqmn) == 2
    g = @(t,s) [v*((-XS_HOMO.D*bsqmn(1)+sigmaE+ ...
        FB*phi0mn(1,1))*s(1)+...
        FB*phi0mn(2,1)*s(4)- ...
        sigmaX*phi0mn(1,1)*s(3)- ...
        sigmaX*phi0mn(2,1)*s(6)); % phi 1
        
        gammaI*XS_HOMO.NF/(nu*keff)*s(1)-lambdaI*s(2); %Iodine 1
        
        lambdaI*s(2)+...
        (gammaX*XS_HOMO.NF/(keff*nu)-sigmaX*X0mn(1,1))*s(1)- ...
        sigmaX*X0mn(2,1)*s(4)- ...
        (lambdaX+sigmaX*phi0mn(1,1))*s(3)- ...
        sigmaX*phi0mn(2,1)*s(6); %Xenon 1
        
        
        v*((-XS_HOMO.D*bsqmn(2)+sigmaE+ ...
        FB*phi0mn(2,2))*s(4)+ ...
        FB*phi0mn(1,2)*s(1)- ...
        sigmaX*phi0mn(2,2)*s(6)- ...
        sigmaX*phi0mn(1,2)*s(3)); %Phi 2
        
        gammaI*XS_HOMO.NF/(nu*keff)*s(4)-lambdaI*s(5); %Iodine 2
        
        lambdaI*s(5)+ ...
        (gammaX*XS_HOMO.NF/(keff*nu)-sigmaX*X0mn(2,2))*s(4)- ...
        sigmaX*X0mn(1,2)*s(1)- ...
        (lambdaX+sigmaX*phi0mn(2,2))*s(6)- ...
        sigmaX*phi0mn(1,2)*s(3); ... "Xenon 2
        ]; 
elseif length(bsqmn) == 3
    g = @(t,s) [v*((-XS_HOMO.D*bsqmn(1)+sigmaE+ ...
        FB*phi0mn(1,1))*s(1)+ ...
        FB*phi0mn(2,1)*s(4)+ ...
        FB*phi0mn(3,1)*s(7) - ...
        sigmaX*phi0mn(1,1)*s(3)- ...
        sigmaX*phi0mn(2,1)*s(6)- ...
        sigmaX*phi0mn(3,1)*s(9)); % Phi 1
        
        gammaI*XS_HOMO.NF/(nu*keff)*s(1)-lambdaI*s(2); % Iodine 1
        
        lambdaI*s(2)+ ...
        (gammaX*XS_HOMO.NF/(keff*nu)-sigmaX*X0mn(1,1))*s(1)- ...
        sigmaX*X0mn(2,1)*s(4)- ...
        sigmaX*X0mn(3,1)*s(7)- ...
        (lambdaX+sigmaX*phi0mn(1,1))*s(3)- ...
        sigmaX*phi0mn(2,1)*s(6)- ...
        sigmaX*phi0mn(3,1)*s(9); % Xenon 1
        
        
        v*((-XS_HOMO.D*bsqmn(2)+sigmaE+ ...
        FB*phi0mn(2,2))*s(4)+ ...
        FB*phi0mn(1,2)*s(1)+ ...
        FB*phi0mn(3,2)*s(7) - ...
        sigmaX*phi0mn(1,2)*s(3)- ...
        sigmaX*phi0mn(2,2)*s(6)- ...
        sigmaX*phi0mn(3,2)*s(9)); % Phi 2
        
        gammaI*XS_HOMO.NF/(nu*keff)*s(4)-lambdaI*s(5); % Iodine 2
        
        lambdaI*s(5)+ ...
        (gammaX*XS_HOMO.NF/(keff*nu)-sigmaX*X0mn(2,2))*s(4)- ...
        sigmaX*X0mn(1,2)*s(1)- ...
        sigmaX*X0mn(3,2)*s(7)- ...
        (lambdaX+sigmaX*phi0mn(2,2))*s(6)- ...
        sigmaX*phi0mn(1,2)*s(3)- ...
        sigmaX*phi0mn(3,2)*s(9); % Xenon 2
        
        
        v*((-XS_HOMO.D*bsqmn(3)+sigmaE+ ...
        FB*phi0mn(3,3))*s(7)+ ...
        FB*phi0mn(1,3)*s(1)+ ...
        FB*phi0mn(2,3)*s(4) - ...
        sigmaX*phi0mn(1,3)*s(3)- ...
        sigmaX*phi0mn(2,3)*s(6)- ...
        sigmaX*phi0mn(3,3)*s(9)); % Phi 3
        
        gammaI*XS_HOMO.NF/(nu*keff)*s(7)-lambdaI*s(8); % Iodine 3
        
        lambdaI*s(8)+ ...
        (gammaX*XS_HOMO.NF/(keff*nu)-sigmaX*X0mn(3,3))*s(7)- ...
        sigmaX*X0mn(1,3)*s(1)- ...
        sigmaX*X0mn(2,3)*s(4)- ...
        (lambdaX+sigmaX*phi0mn(3,3))*s(9)- ...
        sigmaX*phi0mn(1,3)*s(3)- ...
        sigmaX*phi0mn(2,3)*s(6);]; % Xenon 3

else
"error"
end

%call ODE15s
if method == "ode15s"
[time, state_values] = ode15s(g,tspan,IC,opts);
elseif method == "ode45"
[time, state_values] = ode45(g,tspan,IC);
end

% function sdot = g(t,s)
% 
% sdot = [v*((XS_HOMO.D*bsq+sigmaE-sigmaX*X0m)*s(1)-sigmaX*phi0m*s(3));
%     gammaI*XS_HOMO.NF/(nu*keff)*s(1)-lambdaI*s(2);
%     lambdaI*s(2)+(gammaX*XS_HOMO.NF/(keff*nu)-sigmaX*X0m)*s(1)-(lambdaX+sigmaX*phi0m)*s(3)];
% end


