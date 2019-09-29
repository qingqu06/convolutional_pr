clc;close all;clear all;



figure;
load data_conv_basis;
load data_rand_basis;
subplot(1,3,1); hold on;
plot(ratio, Prb_conv);
plot(ratio, Prb_rand);
xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
legend('random convolution model','i.i.d. random model');
norm_x

load data_rand_rand;
load data_rand_rand;
subplot(1,3,2); hold on;
plot(ratio, Prb_conv);
plot(ratio, Prb_rand);
xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
legend('random convolution model','i.i.d. random model');
norm_x



load data_conv_ones;
load data_rand_ones;
subplot(1,3,3); hold on;
plot(ratio, Prb_conv);
plot(ratio, Prb_rand);
xlabel('Ratio: m/n'); ylabel('Recovery Probability'); 
legend('random convolution model','i.i.d. random model');
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