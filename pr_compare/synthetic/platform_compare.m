clc;close all;clear all;

% parameters for the algorithm
opts.MaxIter = 1e4;
opts.tol = 1e-5;
opts.MaxIter_pwr = 1e4;
opts.pwr_tol = 1e-5;
opts.isprint = 0;
% parameter for problem
n = 100;
times = 100;
ratio = [2:2:60];
%x_0 = rand(n,1)/sqrt(2) + 1i * randn(n,1)/sqrt(2);
%x_0 = x_0 /norm(x_0);

%   x_0 = zeros(n,1);
%  x_0(1) = 1;
x_0 = ones(n,1)/sqrt(n);
norm_x = norm(fft(x_0),'inf');

Prb_conv = zeros(length(ratio),1);
Prb_rand = zeros(length(ratio),1);


for r = 1:length(ratio)
    m = ratio(r)*n;

    for t = 1:times
        % generate convolutional model
        a = randn(m,1)/sqrt(2) + 1i * randn(m,1)/sqrt(2);
        y = abs(ifft(fft(a) .* fft([x_0;zeros(m-n,1)] )) );
        z_0 = initialize(y, a, n, opts);
        
        [z,err] = Grad_Descent_1(y,a,x_0,z_0,opts);
        if(err<=opts.tol)
            Prb_conv(r) = Prb_conv(r) + 1;
        end
        % generate random model
%         opts.isprint = 1;
        A = randn(m,n)/sqrt(2) + 1i * randn(m,n)/sqrt(2);
        y = abs(A * x_0);
        z_0 = initialize_randn(y, A, n, opts);
        [z,err] = Grad_Descent_randn(y,A,x_0,z_0,opts);
        if(err<=opts.tol)
            Prb_rand(r) = Prb_rand(r) + 1;
        end
        if(mod(t,1)==0)
            fprintf('Ratio = %d, t = %d\n', ratio(r), t);
        end
    end
end

Prb_conv = Prb_conv/times;
Prb_rand = Prb_rand/times;
% Prb_ones = Prb_ones/times;

% Prb = Prb/times;
figure;
hold on;
plot(ratio, Prb_conv,'r');
plot(ratio, Prb_rand,'b');

save('data_conv_ones.mat','Prb_conv','x_0','norm_x','ratio');
save('data_rand_ones.mat','Prb_rand','x_0','norm_x','ratio');
% save('data_conv_rand.mat','Prb_rand','x_0','ratio','norm_x','y','a');
% save('data_init.mat','Prb_init','x_0','ratio','norm_x','y','a');
% save('data_ones.mat','Prb_ones','x_0','ratio','norm_x','y','a');
% save('data_randn.mat','Prb','x_0','ratio','norm_x','y','a');
% save('data_ones.mat','Prb','x_0','ratio','norm_x','y','a');

% x = APM(a,x_0,tol);