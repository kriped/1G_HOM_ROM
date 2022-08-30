%% Initialise
clear; clc; close all;

load("Results\Analysis.mat")

%% Create variables
values=zeros(n,length(Analysis(1).CoefValues));
for i = ni:ne
    values(i,:) = Analysis(i).CoefValues;
end
if length(Analysis(1).CoefValues) == 9
    coef_1 = values(:,1);
    alpha_1 = values(:,2);
    im_1 = values(:,3);
    coef_2 = values(:,4);
    alpha_2 = values(:,5);
    im_2 = values(:,6);
    coef_3 = values(:,7);
    alpha_3 = values(:,8);
    im_3 = values(:,9);
elseif length(Analysis(1).CoefValues) == 12
    coef_1 = values(:,1);
    alpha_1 = values(:,2);
    im_1 = values(:,3);
    coef_2 = values(:,4);
    alpha_2 = values(:,5);
    im_2 = values(:,6);
    coef_3 = values(:,7);
    alpha_3 = values(:,8);
    im_3 = values(:,9);
    phase_1 = values(:,10);
    phase_2 = values(:,11);
    phase_3 = values(:,12);
elseif length(Analysis(1).CoefValues) == 6
    coef_1 = values(:,1);
    alpha_1 = values(:,2);
    coef_2 = values(:,3);
    alpha_2 = values(:,4);
    coef_3 = values(:,5);
    alpha_3 = values(:,6);
end
%% Plot
fig1 = figure();
plot(ni:ne,alpha_1,'o')
hold on     
plot(mat_vals_1,'o')
legend("Numerical results", "Analytical results");
title(sprintf("First stability coefficient of %i modes",n+1));
xlabel("Mode #")
ylabel("Re(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig1,"Results/re_omega1.png")
hold off

fig2 = figure();
plot(ni:ne,alpha_2,'o')
hold on 
plot(mat_vals_2,'o')
legend("Numerical results", "Analytical results");
title(sprintf("Second stability coefficient of %i modes",n+1));
xlabel("Mode #")
ylabel("Re(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig2,"Results/re_omega2.png")
hold off

fig3 = figure();
plot(ni:ne,alpha_3,'o')
hold on 
plot(mat_vals_3,'o')
legend("Numerical results", "Analytical results");
title(sprintf("Third stability coefficient of %i modes",n+1));
xlabel("Mode #")
ylabel("Re(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig3,"Results/re_omega3.png")
hold off

fig4 = figure();
plot(ni:ne,im_1,'o')
hold on 
plot(mat_vals_im1,'o')
legend("Numerical results", "Analytical results");
title(sprintf("First oscillation coefficient of %i modes",n+1));
xlabel("Mode #")
ylabel("Im(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig4,"Results/im_omega1.png")
hold off

fig5 = figure();
plot(ni:ne,im_2,'o')
hold on 
plot(mat_vals_im2,'o')
title(sprintf("Second oscillation coefficient of %i modes",n+1));
xlabel("Mode #")
ylabel("Im(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig5,"Results/im_omega2.png")
hold off

fig6 = figure();
plot(ni:ne,im_3,'o')
hold on 
plot(mat_vals_im3,'o')
legend("Numerical results", "Analytical results");
title(sprintf("Third oscillation coefficient of %i modes",n+1));
xlabel("Mode #")
ylabel("Im(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig6,"Results/im_omega3.png")
hold off