clear variables; close all; clc;
cd('C:\Users\kriped\Chalmers\Christophe Demaziere - XEROM\Matlab code\1G_HOM_REAL_MAIN_SC')
addpath('code')
addpath('input')
addpath('C:\Users\kriped\Chalmers\Christophe Demaziere - XEROM\CORE_SIM_1.2_edited\input')
load Nodal_Values.mat
load GEOM_data.mat
load RESULTS.mat
% create input folder for the ROM
% if not(isfolder('input'))
%     mkdir('input')
% end
% 
% if not(isfolder('temp'))
%     mkdir('temp')
% end

%load coresim results



% Clear old variable CORESIM variables



% Reactor and physical constants
% XS_HOMO.D = XS_HOMO.D(1);
% XS_HOMO.NF = XS_HOMO.NF(1);
% XS_HOMO.SA = XS_HOMO.SA(1);
% XS_HOMO.STR = XS_HOMO.STR(1);
% XS_HOMO.KF = XS_HOMO.KF;

height = 388.62; %cm
radius = 180.87; %cm
V = pi*radius^2*height;
reactor_power = 3.565e9; % W
lambdaI = 2.87e-5; % s^-1
lambdaX = 2.09e-5; %s^-1
gammaI = 0.062; %branching ration iodine
gammaX = 0.002; %branching ratio xenon
kappa = 0.2976e-10; %W
FB_1G = 1.3e-18;
%drdp = -32e-3/reactor_power; 
%sigmaX = 2.7e-18; %microscopic xenon CS (cm^-1)

run('code/Condense_XS.m')
run('code/Homogenize_XS.m')
sigmaX = XS_HOMO.sigmaX; %SigmaX  
%v = 2.2e5; %thermal neutron speed (cm/s)
clear MOD1 MOD2 MOD1_adj MOD2_adj FLX1 FLX2 FLX_CON RES_FLX STR1 STR2 ...
    XS_CON FLX_HOMO lambda lambda_adj nmode n_restart RES_MOD RES_MOD_adj XS...
    Lambda keff conv_ERAM conv_POW n_iter MOD_CON m i 
%drdp = -15e-3/reactor_power; 
nu = 2.44;

%FB_1G=FB_1G/nu;
v = 1/XS_HOMO.v; % Homogenised velocity

% Describe modes
modes = [0 0 0 ; 1 0 0 ; 0 1 0;...
    0 2 0; 1 1 0; 1 2 0; 2 0 0; 0 3 0;...
    0 4 0;2 1 0;2 2 0; 0 0 1; 1 3 0;1 4 0;...
    1 0 1;0 5 0;0 6 0;2 3 0;2 4 0;1 5 0];

nmodes = length(modes);
ncells = 75;
cellvol = V/((ncells*2)^2*ncells);
%calculate all the modes
for i = 1:nmodes
     [phi(:,:,:,i),bsq(i)]=HOMO_Reactor_MODE_radial(modes(i,1),modes(i,2),modes(i,3),radius,height,ncells);
 end
%%
keff = XS_HOMO.NF/(XS_HOMO.D*bsq(1)+XS_HOMO.SA); % calculate keff
kn = XS_HOMO.NF./(XS_HOMO.D.*bsq+XS_HOMO.SA); % calculate eigenvalues of each mode
sigmaE = XS_HOMO.NF/keff-XS_HOMO.SA;

save('C:\Users\kriped\Chalmers\Christophe Demaziere - XEROM\Matlab code\1G_HOM_REAL_MAIN_SC\input\input_data.mat')

run Crossterms