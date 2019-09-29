function z_0 = initialize(y, a, n, opts)
m = length(y);
func_proj = @(w) w(1:n);
func_Az = @(w) ifft(fft(a) .* fft([w;zeros(m-n,1)] ));
func_Az_1 = @(w)  func_proj(ifft( conj(fft(a)) .*fft(w) ));

lambda = 1/sqrt(m) * norm(y);

%compute the leading eigenvector 
z = randn(n,1)/sqrt(2) + 1i *  randn(n,1)/sqrt(2);
z = z / norm(z);
for k = 1:opts.MaxIter_pwr
    z_old = z;
    Ay = y.^2 .* func_Az(z);
    z = 1/m * func_Az_1(Ay);
    z = z/ norm(z);
    err = norm(z - z_old)/ norm(z);
    if err<opts.pwr_tol
        break;
    end
end

z_0 = lambda * z;

end