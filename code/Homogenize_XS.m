clear all; close all; clc;
cd('C:\Users\kriped\Documents\XEROM\Matlab code\ROM_Analytical\')
load('Temp/Condensed_output.mat')

Nnodes = size(XS.D1);

V = (Assembly_pitch/2*Nnodes(1))^2*Node_height*Nnodes(3); %Volume of entire system including missing pins
v = (Assembly_pitch/2)^2* Node_height; %Volume of elemental node element

%All Assemblies have the same volume so it drops out of the equation
FLX_HOMO = squeeze(sum(FLX_CON,[1 2 3])); %Homogenised Modes

XS_HOMO.SA = squeeze(sum(XS_CON.SA.*FLX_CON,[1 2 3])./FLX_HOMO); %Homogenised Absorbtion XS

XS_HOMO.NF = squeeze(sum(XS_CON.NF.*FLX_CON,[1 2 3])./FLX_HOMO); % Homogenised Nu*Fission XS 

XS_HOMO.KF = squeeze(sum(XS_CON.KF.*FLX_CON,[1 2 3])./FLX_HOMO); % Homogenised Kappa * Fission XS

XS_HOMO.STR = squeeze(sum(XS_CON.STR.*FLX_CON,[1 2 3])./FLX_HOMO); % Homogenised Transport XS

XS_HOMO.D = 1./(3*XS_HOMO.STR); % Homogenised Diffusion constant


save('Temp/Homogenised_data.mat')



