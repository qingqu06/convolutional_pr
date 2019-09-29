clc; close all; clear all;
% parameters for algorithm
opts.MaxIter = 10000;
opts.tol = 1e-3;
opts.MaxIter_pwr = 50;
opts.pwr_tol = 1e-2;
opts.isprint = 1;

% parameters for the test

% Im = double( imread('morningside.jpg') );
% Im = double( imread('IsolatedSerumLDL1.png') );
% Im = double( imread('lung_04_3_crop.jpg') );
Im = double( imread('Misc_pollen.jpg') );
[n_1,n_2,~] = size(Im);
n_1 = round(n_1/2);
n_2 = round(n_2);
opts.n_1 = n_1; opts.n_2 = n_2;

x_0 = Im(1:n_1, 1:n_2, 1);
x_0 = x_0(:);
norm_X = norm(x_0);
opts.norm_X = norm_X;
x_0 = x_0/norm_X;
X = reshape(x_0,n_1,n_2);

figure(1);
imshow(uint8(X * norm_X) );
n = n_1*n_2;
% m = round(4*n*log(n));
m = 35*n;
a = randn(m,1)/sqrt(2) + 1i * randn(m,1)/sqrt(2);

y = abs(cconv(a,x_0,m));
% 
% z_0 = rand(n,1)/sqrt(2) + 1i * randn(n,1)/sqrt(2);
tStart = tic;
z_0 = initialize(y, a, n, opts);
t_init = toc(tStart);
opts.t_init = t_init;
Z_0 = reshape(z_0,n_1,n_2);
figure(2);
imshow(uint8(abs(Z_0) * norm_X) );

[z,err,z_all,T] = Grad_Descent(y,a,x_0,z_0,opts);
