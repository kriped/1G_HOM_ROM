%% Initialise
clear; clc; close all;

load 'Results\Analysis_lsq.mat' Analysis ni ne n
load '..\ROM_Analytical_SC\Results\Analysis_lsq.mat' mathematica_values_1 mathematica_values_2 mathematica_values_3

%mathematica_values_3(3)=[]; %Fix for random 0
mat_vals_1 = mathematica_values_1(ni:ne);
mat_vals_2 = mathematica_values_2(ni:ne);
mat_vals_3 = mathematica_values_3(ni:ne);

%% Create variables
coef_1 = zeros(1,n); coef_2 = zeros(1,n); coef_3 =zeros(1,n);
alpha_1= zeros(1,n); alpha_2= zeros(1,n); alpha_3= zeros(1,n);
im_1 = zeros(1,n); im_2 = zeros(1,n);im_3 = zeros(1,n);

mat_vals_im1 = imag(mat_vals_1(ni:ne));
mat_vals_1 = real(mat_vals_1(ni:ne));
mat_vals_im2 = imag(mat_vals_2(ni:ne));
mat_vals_2 = real(mat_vals_2(ni:ne));
mat_vals_im3 = imag(mat_vals_3(ni:ne));
mat_vals_3 = real(mat_vals_3(ni:ne));

for i = ni:ne
    coef_1(i) = Analysis(i).vestimated(1);
    alpha_1(i) = real(Analysis(i).vestimated(2));
    im_1(i) = imag(Analysis(i).vestimated(2));
    coef_2(i) = Analysis(i).vestimated(3);
    alpha_2(i) = real(Analysis(i).vestimated(4));
    im_2(i) = imag(Analysis(i).vestimated(4));
    coef_3(i) = Analysis(i).vestimated(5);
    alpha_3(i) = real(Analysis(i).vestimated(6));
    im_3(i) = imag(Analysis(i).vestimated(6));
end

%% Plot
fig1 = figure();
plot(ni:ne,alpha_1,'o')
hold on     
plot(mat_vals_1,'o')
legend("Numerical results", "Analytical results");
title(sprintf("First stability coefficient of %i modes",n));
xlabel("Mode #")
ylabel("Re(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig1,"Results/re_omega1.png")
hold off
err1 = abs(mat_vals_1-alpha_1)./abs(mat_vals_1);
err1
fig2 = figure();
plot(ni:ne,alpha_2,'o')
hold on 
plot(mat_vals_2,'o')
legend("Numerical results", "Analytical results");
title(sprintf("Second stability coefficient of %i modes",n));
xlabel("Mode #")
ylabel("Re(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig2,"Results/re_omega2.png")
hold off
err2 = abs(mat_vals_2-alpha_2)./abs(mat_vals_2);
err2

fig3 = figure();
plot(ni:ne,alpha_3,'o')
hold on 
plot(mat_vals_3,'o')
legend("Numerical results", "Analytical results");
title(sprintf("Third stability coefficient of %i modes",n));
xlabel("Mode #")
ylabel("Re(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig3,"Results/re_omega3.png")
hold off
err3 = abs(mat_vals_3-alpha_3)./abs(mat_vals_3);
err3

fig4 = figure();
plot(ni:ne,im_1,'o')
hold on 
plot(mat_vals_im1,'o')
legend("Numerical results", "Analytical results");
title(sprintf("First oscillation coefficient of %i modes",n));
xlabel("Mode #")
ylabel("Im(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig4,"Results/im_omega1.png")
hold off
err_im1 = abs(mat_vals_im1-im_1)./abs(mat_vals_im1);
err_im1

fig5 = figure();
plot(ni:ne,im_2,'o')
hold on 
plot(mat_vals_im2,'o')
title(sprintf("Second oscillation coefficient of %i modes",n));
xlabel("Mode #")
ylabel("Im(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig5,"Results/im_omega2.png")
hold off
err_im2 = abs(mat_vals_im2-im_2)./abs(mat_vals_im2);
err_im2


fig6 = figure();
plot(ni:ne,im_3,'o')
hold on 
plot(mat_vals_im3,'o')
legend("Numerical results", "Analytical results");
title(sprintf("Third oscillation coefficient of %i modes",n));
xlabel("Mode #")
ylabel("Im(\omega)")
yline(0)
legend("Numerical results", "Analytical results","0-line");
saveas(fig6,"Results/im_omega3.png")
hold off
err_im3 = abs(mat_vals_im3-im_3)./abs(mat_vals_im3);
err_im3
