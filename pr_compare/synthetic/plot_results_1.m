clc;close all;clear all;
load data_x_1.mat;
load data_x_rand.mat;
ratio_1 = ratio;
load data_x_ones.mat;


figure;
subplot(1,3,1); plot(ratio_1, Prb_x_1,'r');
xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
title('x');
subplot(1,3,2);  plot(ratio_1, Prb_x_rand,'b');
xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
title('x');
subplot(1,3,3); plot(ratio, Prb_x_ones/100,'g');
xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
title('x');

% legend('spectral','random','z = 1');