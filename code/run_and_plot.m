%% Initialise
clc; clear; close all;
ni = 1; ne= 20; n= ne-ni+1;
ExMode = 2;
exmodeidx = (ExMode-1)*3+1;
IC = zeros(1,3*n);
IC(exmodeidx) = 0.01;

t0 = 0; tf = 3; %time in seconds
tspan = [t0, tf];
opts=odeset("MaxStep",0.01); % Options for solver

[time,state_values] = ODE_NSolve(IC,tspan,opts,n);

time1 = time;
solution1 = state_values;
%% run full solution

nhours = 70;
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
 load("../Results\Analysis_lsq.mat",'phi0mat')
 figure(1)
 k=heatmap(phi0mat,'FontSize',13)
 k.Position=[0.140 0.1400 0.65 0.8];
 xlabel("Mode m")
 ylabel("Mode n")
 annotation('textarrow',[1,1],[0.5,0.5],'string','[cm^{-2}\cdot s^{-1}]', ...
      'HeadStyle','none','LineStyle','none','HorizontalAlignment','center','TextRotation',-90,'FontSize',13);
 
%save("Results\time_dev.mat")
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


yyaxis left
plot(tot_time,tot_sol(:,([2,15]-1)*3+1))
ylim([-1.3E-7 , 1E-7])
ylabel("Amplitude [AU]",'Fontsize', 14)
yyaxis right
plot(tot_time,tot_sol(:,([1,7,12]-1)*3+1))
ylim([-1.2E-6 , 2.6E-6])
yl = ylabel("Amplitude [AU]",'Fontsize', 14,"Rotation",-90);
yl.Position(1) = 78; 
legend(["Mode 2" "Mode 15" "Mode 1" "Mode 7" "Mode 12"],"Location","North")
xlabel("Time [h]",'Fontsize', 14)

xlim([0 70]);
grid on
hold off

%% Full flux
load ../Results\test_spatial.mat

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
figure(3)
plot(tot_time,temp_spatial_point_1)
xlabel("Time [h]", 'Fontsize', 14)
ylabel("Normalized neutron flux [AU]",'Fontsize', 14)
%title('Time signal sa in the reactor')
ylim([-1.1E-6,5E-7])
xlim([0 70]);
grid on
% %% Plot 4-11
% figure(5);
% hold on
% for i = 1:20 
%     if any([4,11] == i)
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     else
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');   
%     end
% end
% %'color',[0.6350 0.0780 0.1840
% hold off
% %set(gca,"YScale","log")
% %set(p,'Color','k')
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% legend
% xlim([0,5])
% ylim([-1E-3,1E-3])
% title('Mode 4 and 11')
% %% Plot 5
% 
% figure(6);
% hold on
% for i = 1:20 
%     if any([5] == i)
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     else
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');   
%     end
% end
% %'color',[0.6350 0.0780 0.1840
% hold off
% %set(gca,"YScale","log")
% %set(p,'Color','k')
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% legend
% xlim([0,1])
% ylim([-1E-3,1E-3])
% title('Mode 5')
% %% Plot 6
% 
% figure(7);
% hold on
% for i = 1:20 
%     if any([6] == i)
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     else
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');   
%     end
% end
% %'color',[0.6350 0.0780 0.1840
% hold off
% %set(gca,"YScale","log")
% %set(p,'Color','k')
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% legend
% xlim([0,5])
% ylim([-1E-3,1E-3])
% title('Mode 6')
% %% Plot 13
% figure(8);
% hold on
% for i = 1:20 
%     if 13 == i
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     else
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');   
%     end
% end
% %'color',[0.6350 0.0780 0.1840
% hold off
% %set(gca,"YScale","log")
% %set(p,'Color','k')
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% legend
% xlim([0,5])
% ylim([-1E-3,1E-3])
% title('Mode 13')
% %% Plot 14
% 
% figure(9);
% hold on
% for i = 1:20 
%     if 14 == i
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     else
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');   
%     end
% end
% %'color',[0.6350 0.0780 0.1840
% hold off
% %set(gca,"YScale","log")
% %set(p,'Color','k')
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% legend
% xlim([0,5])
% ylim([-1E-3,1E-3])
% title('Mode 14')
% %% Plot 16
% 
% figure(10);
% hold on
% for i = 1:20 
%     if 16 == i
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     else
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');   
%     end
% end
% %'color',[0.6350 0.0780 0.1840
% hold off
% %set(gca,"YScale","log")
% %set(p,'Color','k')
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% legend
% xlim([0,5])
% ylim([-1E-3,1E-3])
% title('Mode 16')
% 
% %% Plot 17
% 
% figure(11);
% hold on
% for i = 1:20 
%     if 17 == i
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     else
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');   
%     end
% end
% %'color',[0.6350 0.0780 0.1840
% hold off
% %set(gca,"YScale","log")
% %set(p,'Color','k')
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% legend
% xlim([0,5])
% ylim([-1E-3,1E-3])
% title('Mode 17')
% 
% %% Plot 20
% 
% figure(12);
% hold on
% for i = 1:20 
%     if 20 == i
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'LineWidth',2,'Color',[0 0.4470 0.7410]);
%     else
%      plot(tot_time,tot_sol(:,(i-1)*3+1),'color','k','LineStyle','--');   
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
% ylim([-1E-3,1E-3])
% title('Mode 20')
% 
% %% zoom in on signal
% 
% figure(13)
% 
% plot(tot_time,tot_sol(:,exmodeidx))
% xlabel("Time (hours)")
% ylabel("\phi[(cm^2 s)^{-1}]")
% xlim([0,30])
% 
% title('Zoom on oscialltory mode')