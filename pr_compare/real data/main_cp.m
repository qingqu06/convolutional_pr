clc; close all; clear all;
% parameters for algorithm
opts.MaxIter = 2500;
opts.tol = 1e-4;
opts.MaxIter_pwr = 50;
opts.pwr_tol = 1e-4;
opts.isprint = 1;

% parameters for the test
Im = double(imread('x-ray-images.jpg') );
[m_1,m_2,r] = size(Im);
Im_rec = zeros(m_1,m_2,r);
n = m_1*m_2;
m = round(5*n);
A = randn(m,n)/sqrt(2) + 1i * randn(m,n)/sqrt(2);
Err = zeros(r,1);
tic;
for t = 1:r
    x_0 = Im(:,:,t);
    x_0 = x_0(:);
    y = abs(A*x_0);
    %pwr iteration
    z0 = randn(n,1)/sqrt(2) + 1i * randn(n,1)/sqrt(2); z0 = z0/norm(z0,'fro');    % Initial guess
    for tt = 1:opts.MaxIter_pwr                      % Power iterations
        z0 = A'*(y.* (A*z0)); z0 = z0/norm(z0,'fro');
    end
    z = z0 *1/sqrt(m) * norm(y);
    for k = 1: opts.MaxIter
        yz = A*z;
        Grad = yz - y.*(yz./abs(yz));
        Grad = A'*yz;
        z = z - 1/m * Grad;             % Gradient update
    end
    
    Im_rec(:,:,t) = round(abs(reshape(z,m_1,m_2)));
end
toc;
figure;
subplot(1,2,1); imshow(uint8(Im));
subplot(1,2,2); imshow(uint8(Im_rec));
