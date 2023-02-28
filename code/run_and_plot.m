%% Initialise
clc; clear; close all;
cd('C:\Users\kriped\Chalmers\Christophe Demaziere - XEROM\Matlab code\1G_HOM_REAL_MAIN_SC')
addpath('code')
ni = 1; ne= 10; n= ne-ni+1;
ExMode = 2;
exmodeidx = (ExMode-1)*3+1;
IC = zeros(1,3*n);
%IC(exmodeidx) = 1.2e+13;
IC(exmodeidx) = 5.9e+12;
t0 = 0; tf = 3; %time in seconds
tspan = [t0, tf];
opts=odeset("MaxStep",0.01); % Options for solver

[time,state_values] = ODE_NSolve(IC,tspan,opts,n);

time1 = time;
solution1 = state_values;
%% run full solution

nhours = 150;
t0 = time1(end); tf = nhours * 3600; % start time = end time of initialisation, end time= # hours converted to seconds

tspan = [t0, tf];

IC = solution1(end,:);

opts=odeset("MaxStep",10); % Options for solver

[time,state_values] = ODE_NSolve(IC,tspan,opts,n);

time2 = time;
solution2 = state_values;

tot_time = [time1;time2];
tot_time = tot_time/3600;
tot_sol = [solution1;solution2];
 %% heatmap    
%  load("Results\Analysis_lsq.mat",'phi0mat')
%  figure(1)
%  k=heatmap(phi0mat,'FontSize',13);
%  k.Position=[0.140 0.1400 0.65 0.8];
%  xlabel("Mode m")
%  ylabel("Mode n")
%  annotation('textarrow',[1,1],[0.5,0.5],'string','[cm^{-2}\cdot s^{-1}]', ...
%       'HeadStyle','none','LineStyle','none','HorizontalAlignment','center','TextRotation',-90,'FontSize',13);
 
%save("Results\time_dev.mat")
save("C:/Users/kriped/Chalmers/Christophe Demaziere - XEROM/Matlab code/1G_HOM_REAL_MAIN_SC/Results/time_dev.mat")
%% Plot 1 - 7 - 12
% close all
% figure(2);
% hold on
% for i = 1:20
%     if 1 == i
%         plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     elseif 7 == i
%         plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[1 0 0]);
%     elseif 12 == i
%         plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 1 0]);
%     else
%         plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');
%     end
% end
% %'color',[0.6350 0.0780 0.1840
% hold off
% %set(gca,"YScale","log")
% %set(p,'Color','k')
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% legend
% % xlim([0,60])
% ylim([-1E-2,1E-2])
% title('Mode 1, 7 and 12')
% %% Plot 2 - 15
% figure(3);
% hold on
% for i = 1:20
%     if 2 == i
%         plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     elseif 15 == i
%         plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[1 0 0]);
%     else
%         plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');
%     end
% end
% %'color',[0.6350 0.0780 0.1840
% hold off
% %set(gca,"YScale","log")
% %set(p,'Color','k')
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% legend
% %xlim([0,10])
% ylim([-1E-2,1E-2])
% title('Mode 2 and 15')
% 
%  %% Plot 3 -10
% figure(4);
% hold on
% for i = 1:20
%     if 3 == i
%         plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     elseif 10 == i
%         plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[1 0 0]);
%     else
%         plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');
%     end
% end
% %'color',[0.6350 0.0780 0.1840
% hold off
% %set(gca,"YScale","log")
% %set(p,'Color','k')
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% legend
% xlim([0,10])
% ylim([-1,1])
% title('Mode 3 and 10')
% 
%% article plot suggestion 2
figure(2)
%yyaxis left
plot(tot_time(100:end),tot_sol(100:end,([1 2 7]-1)*3+1))
%ylim([-2e5,2e5])
ylabel("Amplitude [AU]","Fontsize", 14)
xlabel("Time [h]",'Fontsize', 14)
legend("Mode 1 ", "Mode 2 ", "Mode 3 ")
xlim([0 70]);
grid on
hold off
% yyaxis right
% plot(tot_time,tot_sol(:,([1,7,12]-1)*3+1))
% ylim([-4E-9 , 8E-9])
% yl = ylabel("Amplitude [AU]",'Fontsize', 14,"Rotation",-90);
% yl.Position(1) = 78; 
% legend(["Mode 2" "Mode 15" "Mode 1" "Mode 7" "Mode 12"],"Location","North")




% figure(4)
% plot(tot_time,tot_sol(:,([1, 2, 3, 4]-1)*3+1))
% ylim([-5E-9 , 5E-9])
% xlim([0 1])
% ylabel("P_{m}(t) Amplitudes (cm^{-2}*s^{-1})",'Fontsize', 14)
% legend(["Eq mode", "ax mode", "rad mode 1", "rad mode 2"],"Location","best")
% xlabel("Time [h]",'Fontsize', 14)
% grid on


% figure(5)
% plot(tot_time,tot_sol(:,([1, 2, 3, 4]-1)*3+1))
% ylim([-1.3E-9 , 1E-9])
% xlim([0 70])
% ylabel("P_{m}(t) Amplitudes (cm^{-2}*s^{-1})",'Fontsize', 14)
% legend(["Eq mode", "ax mode", "rad mode 1", "rad mode 2"],"Location","best")
% xlabel("Time [h]",'Fontsize', 14)
% grid on
% hold off
%% Full flux
load Results\test_spatial.mat

%%
tot_sol_phi = tot_sol(:,1:3:3*n);
r = 180.87;
h = 388.62;
%%
phi_point_1 = zeros(1,n);

phi_point_1(1,:) = phi(100,100,50,1:n);

temp_spatial_point_1 = tot_sol_phi*phi_point_1';

%%First measurement point

% figure(1)
% phi_dim = size(phi);
%point_1_height=h/phi_dim(3) * phi_point_1;
%plot(phi())
%% plot first point
figure(3)
plot(tot_time(100:end),temp_spatial_point_1(100:end))
xlabel("Time [h]", 'Fontsize', 14)
ylabel("Normalized neutron flux [cm^{-2}s^{-1}]",'Fontsize', 14)
%title('Time signal sa in the reactor')
%ylim([-8e4,8e4])
xlim([0 150]);
grid on
