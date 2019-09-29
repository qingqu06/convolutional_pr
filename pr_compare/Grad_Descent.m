function [z, err, Z_all,T] = Grad_Descent(y,a,x_0,z_0,opts)
m = length(y);
n = length(x_0);
tau = 0.01;
opts.f_val_tol = 1e-5;
eta = 0.9;

func_proj = @(w) w(1:n);
func_Az = @(w) ifft(fft(a) .* fft([w;zeros(m-n,1)] ));
func_Az_1 = @(w)  func_proj(ifft( conj(fft(a)) .*fft(w) ));

dist = @(w) norm(x_0 - exp(-1i*angle(x_0'*w))*w)/norm(x_0);
func_val = @(w) 1/(2*m)* sum( (y -  abs(cconv(a,w,m))).^2  ) ;
z = z_0;
Z_all = cell(opts.MaxIter,1);
T = zeros(opts.MaxIter,1);
normest = sqrt(sum(y(:))/numel(y))^2;

tau0 = 350;                         % Time constant for step size
mu = @(t) min(1-exp(-t/tau0), normest); % Schedule for step size

t = opts.t_init;
for k = 1:opts.MaxIter
    
    tStart = tic;
    Az = cconv( a, z, m);
    Az_abs = abs(Az);
    f_old = 1/(2*m) * sum((y - Az_abs).^2);
    
    ind = (Az_abs~=0);
    Grad = Az - y .* ( (Az./Az_abs).*ind + 1.*(~ind)  );
%     Grad = cconv( reversal(a), Grad, m);
    Grad = 1/m*func_Az_1(Grad);
%     tau = mu(k)/normest;
%     z = z - tau * Grad;

%     Grad = 1/m * Grad(1:n);
    
%         backtracking linesearch
    tau = min(2*tau,1);
    norm_Grad_2 = sum(abs(Grad).^2);
    while( func_val( z - tau*Grad ) >= f_old - eta * tau * norm_Grad_2  )
        tau = 0.5 * tau;
    end
% %     
    z = z - tau*Grad;
    
        tEnd = toc(tStart);
    T(k) = t + tEnd;
    t = t+tEnd;


%     figure(1);
    Z = reshape(z,opts.n_1,opts.n_2);
    Z_all{k} = Z;
    figure(3);
    imshow(uint8(abs(Z) * opts.norm_X) );
    pause(0.01);
    
    
    
    
    f_val = func_val(z);
    err =  dist(z);
    %     f_err = abs(f_old - f_val);
    
    if(opts.isprint == 1)
        fprintf('Iter = %d, f_val = %f, z_err = %f, stepsize = %f...\n',k,f_val,err,tau);
    end
    if(err <= opts.tol )
        break;
    end
end

end