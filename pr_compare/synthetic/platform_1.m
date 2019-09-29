clc;close all;clear all;

% parameters for the algorithm
opts.MaxIter = 5e3;
opts.tol = 1e-3;
opts.MaxIter_pwr = 5e3;
opts.pwr_tol = 1e-5;
opts.isprint = 0;
% parameter for problem
n = 1000;
times = 100;
ratio = [1:0.5:50];


% load truth.mat;
x_0_1 = zeros(n,1);
x_0_1(1) = 1;
norm_x_1 = norm(fft(x_0_1),'inf');

x_0_rand = rand(n,1)/sqrt(2) + 1i * randn(n,1)/sqrt(2);
x_0_rand = x_0_rand /norm(x_0_rand);
norm_x_rand = norm(fft(x_0_rand),'inf');


x_0_ones = ones(n,1)/sqrt(n);
norm_x_ones = norm(fft(x_0_ones),'inf');


Prb_x_1 = zeros(length(ratio),1);
Prb_x_rand = zeros(length(ratio),1);
Prb_x_ones = zeros(length(ratio),1);

for r = 1:length(ratio)
    m = ratio(r)*n;

    for t = 1:times
        a = randn(m,1)/sqrt(2) + 1i * randn(m,1)/sqrt(2);
        
        y_1 = abs(ifft(fft(a) .* fft([x_0_1;zeros(m-n,1)] )) );
        z_0 = initialize(y_1, a, n, opts);
        [z,err] = Grad_Descent_1(y_1,a,x_0_1,z_0,opts);
        if(err<=opts.tol)
            Prb_x_1(r) = Prb_x_1(r) + 1;
        end
        
        y_rand = abs(ifft(fft(a) .* fft([x_0_rand;zeros(m-n,1)] )) );
        z_0 = initialize(y_rand, a, n, opts);
        [z,err] = Grad_Descent_1(y_rand,a,x_0_rand,z_0,opts);
        if(err<=opts.tol)
            Prb_x_rand(r) = Prb_x_rand(r) + 1;
        end
        
        y_ones = abs(ifft(fft(a) .* fft([x_0_ones;zeros(m-n,1)] )) );
        z_0 = initialize(y_ones, a, n, opts);
        [z,err] = Grad_Descent_1(y_ones,a,x_0_ones,z_0,opts);
        if(err<=opts.tol)
            Prb_x_ones(r) = Prb_x_ones(r) + 1;
        end
        
        if(mod(t,1)==0)
            fprintf('Ratio = %d, t = %d\n', ratio(r), t);
        end
    end
end

Prb_x_1 = Prb_x_1/times;
Prb_x_rand = Prb_x_rand/times;
Prb_x_ones = Prb_x_ones/times;
% save('data_x_1.mat','Prb_x_1','x_0_1','ratio','norm_x_1');
% save('data_x_rand.mat','Prb_x_rand','x_0_rand','ratio','norm_x_rand');
% save('data_x_ones.mat','Prb_x_ones','x_0_ones','ratio','norm_x_ones');
% Prb = Prb/times;
figure;
hold on;
plot(ratio, Prb_x_1,'r');
plot(ratio, Prb_x_rand,'b');
plot(ratio, Prb_x_ones,'g');

save('data_x_1.mat','Prb_x_1','x_0_1','ratio','norm_x_1');
save('data_x_rand.mat','Prb_x_rand','x_0_rand','ratio','norm_x_rand');
save('data_x_ones.mat','Prb_x_ones','x_0_ones','ratio','norm_x_ones');
% save('data_randn.mat','Prb','x_0','ratio','norm_x','y','a');
% save('data_ones.mat','Prb','x_0','ratio','norm_x','y','a');

% x = APM(a,x_0,tol);