
%%
nmode = length(FLX1(1,1,1,:));

XS_CON.SA= (XS.SA1.*FLX1+XS.SA2.*FLX2)./(FLX1+FLX2);% Condesed Absorbtion XS

XS_CON.NF= (XS.NF1.*FLX1+XS.NF2.*FLX2)./(FLX1+FLX2); %Condesed Nu* Fission XS

STR1 = 1/(3*XS.D1);
STR2 = 1/(3*XS.D2);

XS_CON.STR= (STR1.*FLX1+STR2.*FLX2)./(FLX1+FLX2);%Condesed Transport XS

XS_CON.KF = (XS.KN.*XS.NF1.*FLX1+XS.KN.*XS.NF2.*FLX2)./(FLX1+FLX2); %Condensed Kappa * Fission XS

XS_CON.D = 1/(3*XS_CON.STR); % Condensed Diffusion constant

FLX_CON = FLX1+FLX2; %Condensed Flux

MOD_CON = MOD1+MOD2; % Condesed Modes

sigmaX = 2.7000e-18;
XS_CON.sigmaX = sigmaX*FLX2./FLX_CON;
v1 = 2E9; % fast neutron velocity in cm/s 
v2 = 2.2E5; % thermal neutron velocity in cm/s 
XS_CON.v = (1/v1*FLX1+1/v2*FLX2)./FLX_CON;


%Replace NaN with zeroes 
XS_CON.SA(isnan(XS_CON.SA))=0;
XS_CON.NF(isnan(XS_CON.NF))=0;
XS_CON.STR(isnan(XS_CON.STR))=0;
XS_CON.KF(isnan(XS_CON.KF))=0;
XS_CON.D(isnan(XS_CON.D))=0;
XS_CON.sigmaX(isnan(XS_CON.sigmaX))=0;
XS_CON.v(isnan(XS_CON.v))=0;
FLX_CON(isnan(FLX_CON))=0;
MOD_CON(isnan(MOD_CON))=0;
