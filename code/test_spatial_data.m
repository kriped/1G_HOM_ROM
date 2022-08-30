clear all; close all; clc;

% cd('C:\Users\kriped\Documents\XEROM\Matlab code\ROM_Analytical_SC\')

% create input folder for the ROM
% if not(isfolder('input'))
%     mkdir('input')
% end
% 
% if not(isfolder('temp'))
%     mkdir('temp')
% end

%load coresim results
load('../../CORE_SIM_v1.2/output/RESULTS.mat')

%condense and homogenise coresim results
save('input/RESULTS.mat')
run('Condense_XS.m')
run('Homogenize_XS.m')

% Clear old variable CORESIM variables
clear MOD1 MOD2 MOD1_adj MOD2_adj FLX1 FLX2 FLX_CON RES_FLX STR1 STR2 ...
    XS_CON FLX_HOMO lambda lambda_adj nmode n_restart RES_MOD RES_MOD_adj XS...
    Lambda keff conv_ERAM conv_POW n_iter MOD_CON m i 


% Reactor and physical constants
XS_HOMO.D = XS_HOMO.D(1);
XS_HOMO.NF = XS_HOMO.NF(1);
XS_HOMO.SA = XS_HOMO.SA(1);
XS_HOMO.STR = XS_HOMO.STR(1);
XS_HOMO.KF = XS_HOMO.KF(1);

height = 388.62; %cm
radius = 180.87; %cm
power = 3.565e9; % W
lambdaI = 2.87e-5; % s^-1
lambdaX = 2.09e-5; %s^-1
gammaI = 0.062; %branching ration iodine
gammaX = 0.002; %branching ratio xenon
sigmaX = 2.7e-18; %microscopic xenon CS (cm^-1)
v = 2.2e5; %thermal neutron speed (cm/s)
kappa = 0.2976e-10; %W
drdp = -32e-3/power; 
nu = 2.44;


% Describe modes
modes = [0 0 0 ; 1 0 0 ; 0 1 0;...
    0 2 0; 1 1 0; 1 2 0; 2 0 0; 0 3 0;...
    0 4 0;2 1 0;2 2 0; 0 0 1; 1 3 0;1 4 0;...
    1 0 1;0 5 0;0 6 0;2 3 0;2 4 0;1 5 0];

nmodes = length(modes);
ncells = 75;
%calculate all the modes
for i = 1:nmodes
     [phi(:,:,:,i),bsq(i),cellvol]=HOMO_Reactor_MODE_radial(modes(i,1),modes(i,2),modes(i,3),radius,height,ncells);
 end

keff = XS_HOMO.NF/(XS_HOMO.D*bsq(1)+XS_HOMO.SA); % calculate keff
sigmaE = XS_HOMO.NF/keff-XS_HOMO.SA;
clearvars -except phi
save('C:\Users\kriped\Documents\XEROM\Matlab code\ROM_cross_sections\Results\test_spatial.mat')