clc; close all; clear all;
% parameters for algorithm
opts.MaxIter = 10000;
opts.tol = 1e-3;
opts.MaxIter_pwr = 10000;
opts.pwr_tol = 1e-4;
opts.isprint = 1;

% parameters for the test

Im = double( imread('Misc_pollen.jpg') );
[n_1,n_2,~] = size(Im);
n_1 = n_1/10;
n_2 = n_2/10;
x_0 = Im(1:n_1, 1:n_2);
n = 1000;
m = 6*n;
a = randn(m,1)/sqrt(2) + 1i * randn(m,1)/sqrt(2);
x_0 = rand(n,1)/sqrt(2) + 1i * randn(n,1)/sqrt(2);
x_0 = x_0 /norm(x_0);
y = abs(ifft(fft(a) .* fft([x_0;zeros(m-n,1)] )) );
% 
% z_0 = rand(n,1)/sqrt(2) + 1i * randn(n,1)/sqrt(2);
z_0 = initialize(y, a, n, opts);
[z,err] = Grad_Descent(y,a,x_0,z_0,opts);
