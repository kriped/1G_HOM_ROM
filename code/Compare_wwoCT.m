clc; clear; close all;
load("Results\initialise_ct.mat")
load("Results\solutions_short_ct.mat")
load("../ROM_Analytical_SC/Results/initialise.mat")
load("../ROM_Analytical_SC/Results/solutions_short.mat")

%% data prep
solution = struct('time', cell(1, n+1), 'state_values', cell(1, n+1));
solution_ct = struct('time', cell(1, n+1), 'state_values', cell(1, n+1));
for i = ni:ne
solution(i).state_values = [solution1(i).state_values; solution2(i).state_values];
solution(i).time = [solution1(i).time; solution2(i).time];
solution(i).time(10001) = [];
solution(i).state_values(10001,:) = [];

solution_ct(i).state_values = [solution1_ct(i).state_values; solution2_ct(i).state_values];
solution_ct(i).time = [solution1_ct(i).time; solution2_ct(i).time];
solution_ct(i).time(10001) = [];
solution_ct(i).state_values(10001,:) = [];
end

%% Plot phi
for i = 1:n
figure()
plot(solution(i).time/3600,solution(i).state_values(:,1))
hold on
plot(solution_ct(i).time/3600,solution_ct(i).state_values(:,1))
legend("WO CT","With CT")
xlabel("Time (hours)")
ylabel("\phi (n/cm^2/s)")
title(sprintf("Mode %i",i))
hold off
end