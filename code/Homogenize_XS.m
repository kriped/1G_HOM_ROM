%All Assemblies have the same volume so it drops out of the equation
FLX_HOMO = sum(FLX_CON,'all'); %Homogenised Modes

XS_HOMO.SA = sum(XS_CON.SA.*FLX_CON,'all')./FLX_HOMO; %Homogenised Absorbtion XS

XS_HOMO.NF = sum(XS_CON.NF.*FLX_CON,'all')./FLX_HOMO; % Homogenised Nu*Fission XS 

XS_HOMO.KF = sum(XS_CON.KF.*FLX_CON,'all')./FLX_HOMO; % Homogenised Kappa * Fission XS

XS_HOMO.STR = sum(XS_CON.STR.*FLX_CON,'all')./FLX_HOMO; % Homogenised Transport XS

XS_HOMO.D = 1./(3*XS_HOMO.STR); % Homogenised Diffusion constant

XS_HOMO.sigmaX = sum(XS_CON.sigmaX.*FLX_CON,'all')./FLX_HOMO;

XS_HOMO.v = sum(XS_CON.v.*FLX_CON,'all')./FLX_HOMO;



