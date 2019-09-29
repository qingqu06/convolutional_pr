clc;close all;clear all;
load data_x_1.mat;
load data_x_rand.mat;
load data_x_ones.mat;



figure; 

figure;
hold on;
plot(ratio, Prb_x_1,'r');
plot(ratio, Prb_x_rand,'b');
plot(ratio, Prb_x_ones,'g');

% hold on;
% 
% plot(ratio_sparse,Prb_sparse);
% plot(ratio_randn,Prb_randn);
% plot(ratio_ones,Prb_ones);
% 
% figure;
% subplot(1,3,1);plot(ratio_sparse,Prb_sparse);
% xlabel('Ratio: m/n'); ylabel('Recovery Probability'); title('Random Gaussian Signal');
% subplot(1,3,2);plot(ratio_randn,Prb_randn);
% xlabel('Ratio: m/n'); ylabel('Recovery Probability'); title('Random Gaussian Signal');
% subplot(1,3,3);plot(ratio_ones,Prb_ones);
% xlabel('Ratio: m/n'); ylabel('Recovery Probability'); title('Flat Signal');
