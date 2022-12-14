clc; clear; close all;
load("Results\initialise.mat")
load("Results\solutions_short.mat")

%% data prep
solution = struct('time', cell(1, n+1), 'state_values', cell(1, n+1));
for i = ni:ne
solution(i).state_values = [solution1(i).state_values; solution2(i).state_values];
solution(i).time = [solution1(i).time; solution2(i).time];
solution(i).time(10001) = [];
solution(i).state_values(10001,:) = [];
end
%%

Analysis=struct("output",zeros(1,n),...
    "vestimated",zeros(6,n),...
    "resnorm", zeros(1,n),...
    "residuals",zeros(1,n),...
    "exitflag", zeros(1,n)...
);
% analysis(1:20).values = [1:20];
% analysis(1:20).fit = [1:20];
% analysis(1:20).fittype=strings(1,20);
% analysis(1:20).plot = gobjects(1,20);

%% Real part of the three roots for each mode
mathematica_guess_1=[-76.8128 + 2.1684*10^-19i, -96.385 + ...
 2.71051*10^-20i, -104.878, -104.878, -132.024, -132.024, -163.055 - ...
 9.48677*10^-20i, -175.737 + 5.42101*10^-20i, -175.737 + ...
 5.42101*10^-20i, -209.371 + 5.42101*10^-20i, -209.371 + ...
 5.42101*10^-20i, -214.898 + 4.60786*10^-19i, -205.073 + ...
 9.48677*10^-20i, -205.073 + 9.48677*10^-20i, -245.685 - ...
 2.98156*10^-19i, -260.262 + 8.13152*10^-20i, -260.262 + ...
 8.13152*10^-20i, -281.481 + 1.6263*10^-19i, -281.481 + ...
 1.6263*10^-19i, -296.925 + 1.35525*10^-19i];

mathematica_guess_2 = [0.00203742 + 1.06581*10^-14i, 0.000549405 + ...
 1.42109*10^-14i, 0.000172948 - 0.00016294i, 0.000172948 - ...
 0.00016294i, -0.0000581041 - 0.000186354i, -0.0000581041 - ...
 0.000186354i, -0.000173566 - 9.23706*10^-14i, -0.000124533 + ...
 2.84217*10^-14i, -0.000124533 + 2.84217*10^-14i, -0.0000768864 + ...
 2.84217*10^-14i, -0.0000768864 + 2.84217*10^-14i, -0.0000726475 + ...
 1.27898*10^-13i, -0.0000820242 + 7.81597*10^-14i, -0.0000820242 + ...
 7.81597*10^-14i, -0.0000609087 - 1.13687*10^-13i, -0.0000576139 + ...
 1.42109*10^-14i, -0.0000576139 + 1.42109*10^-14i, -0.000053284 + ...
 5.68434*10^-14i, -0.000053284 + 5.68434*10^-14i, -0.0000512083 + ...
 8.52651*10^-14i];

mathematica_guess_3 =[0.0000455368 - 1.06581*10^-14i, 0.000119722 - ...
 1.42109*10^-14i, 0.000172948 + 0.00016294i, 0.000172948 + ...
 0.00016294i, -0.0000581041 + 0.000186354i, -0.0000581041 + ...
 0.000186354i, -0.000352151 + 9.23706*10^-14i, -0.000387488 - ...
 2.84217*10^-14i, -0.000387488 - 2.84217*10^-14i, -0.000594357 - ...
 2.84217*10^-14i, -0.000594357 - 2.84217*10^-14i, -0.000863991 - ...
 1.27898*10^-13i, -0.000397091 - 7.81597*10^-14i, -0.000397091 - ...
 7.81597*10^-14i, -0.000799139 + 1.13687*10^-13i, -0.000620386 - ...
 1.42109*10^-14i, -0.000620386 - 1.42109*10^-14i, -0.000735447 - ...
 5.68434*10^-14i, -0.000735447 - 5.68434*10^-14i, -0.000561543 - ...
 8.52651*10^-14i ...
 ];
%mathematica_values_3(3)=[]; %Fix for random 0
mat_guess_1 = mathematica_guess_1(ni:ne);
mat_guess_2 = mathematica_guess_2(ni:ne);
mat_guess_3 = mathematica_guess_3(ni:ne);

%opts = optimoptions(@lsqnonlin,'Display',"off","Algorithm","levenberg-marquardt");
opts = optimoptions(@lsqnonlin,'Display',"off","Algorithm","trust-region-reflective");
%% Calculate stability
 for i = ni:ne
t=solution(i).time(1:3600);
objfcn = @(v)v(1)*exp(v(2)*t)+v(3)*exp(v(4)*t)+v(5)*exp(v(6)*t)-solution(i).state_values(1:3600,1);
x0 = [Pi,mat_guess_1(i),0.0001,mat_guess_2(i),0.0001,mat_guess_3(i)];
[Analysis(i).vestimated,Analysis(i).resnorm,Analysis(i).residuals,Analysis(i).exitflag,Analysis(i).output] = lsqnonlin(objfcn,x0,[],[],opts);
v1 = Analysis(i).vestimated(1); v2 = Analysis(i).vestimated(2); v3 = Analysis(i).vestimated(3); v4 = Analysis(i).vestimated(4); v5 = Analysis(i).vestimated(5); v6 = Analysis(i).vestimated(6);
f = v1*exp(v2*t)+v3*exp(v4*t)+v5*exp(v6*t);
ref = real(f);
imf = imag(f);
figure()
plot(t,ref)
hold on
plot(t,imf)
plot(t,solution(i).state_values(1:3600,1))
legend("Re(Fit)","Im(Fit)","Num-sol");
title("fit vs numericcal solution")
 end
 %% clean and save results
clear t1 t2 val1 val2 pks locs fig fig1 fig2
save("Results\Analysis_lsq.mat")