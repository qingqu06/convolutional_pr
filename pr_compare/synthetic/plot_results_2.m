clc;close all;clear all;



figure;
load data_ones_basis;
load data_weighted_basis;
subplot(1,3,1); hold on;
plot(ratio, Prb_ones);
plot(ratio, Prb_weighted);
xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
legend('b=1','weights');
norm_x

load data_ones_rand;
load data_weighted_rand;
subplot(1,3,2); hold on;
plot(ratio, Prb_ones);
plot(ratio, Prb_weighted);
xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
legend('b=1','weights');
norm_x



load data_ones_ones;
load data_weighted_ones;
subplot(1,3,3); hold on;
plot(ratio, Prb_ones);
plot(ratio, Prb_weighted);
xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
legend('b=1','weights');
norm_x

% subplot(1,3,1); plot(ratio_1, Prb_x_1,'r');
% xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
% title('x');
% subplot(1,3,2);  plot(ratio_1, Prb_x_rand,'b');
% xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
% title('x');
% subplot(1,3,3); plot(ratio, Prb_x_ones/100,'g');
% xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
% title('x');

% legend('spectral','random','z = 1');