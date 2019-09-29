function z_0 = initialize_randn(y, A, n, opts)
m = length(y);
lambda = 1/sqrt(m) * norm(y);

%compute the leading eigenvector 
z = randn(n,1)/sqrt(2) + 1i *  randn(n,1)/sqrt(2);
z = z / norm(z);
for k = 1:opts.MaxIter_pwr
    z_old = z;
    z = 1/m * A'* (y.^2 .* (A*z));
    z = z/ norm(z);
    err = norm(z - z_old)/ norm(z);
    if err<opts.pwr_tol
        break;
    end
end

z_0 = lambda * z;

end