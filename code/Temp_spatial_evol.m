clear; close all; clc;

load Results\time_dev.mat tot_sol tot_time  
load Results\test_spatial.mat

%%
tot_sol_phi = tot_sol(:,1:3:60);
r = 180.87;
h = 388.62;
%%
phi_point_1 = zeros(1,20);

phi_point_1(1,:) = phi(100,100,50,:);

temp_spatial_point_1 = tot_sol_phi*phi_point_1';

%%First measurement point

figure(1)
phi_dim = size(phi);
%point_1_height=h/phi_dim(3) * phi_point_1;
%plot(phi())
%% plot first point
figure(2)
plot(tot_time,temp_spatial_point_1)
xlabel("Time (Hours)")
ylabel("Normalised neutron flux [AU]")
title('Time signal of point 1 in the reactor')
ylim([-1E-11,1E-11])
xlim([0 70]);

