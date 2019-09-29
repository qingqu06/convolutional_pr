function [z,err] = Grad_Descent(y,a,x_0,z_0,opts)
m = length(y);
n = length(x_0);
tau = 1/m;
opts.f_val_tol = 1e-5;


func_proj = @(w) w(1:n);
func_Az = @(w) ifft(fft(a) .* fft([w;zeros(m-n,1)] ));
func_Az_1 = @(w)  func_proj(ifft( conj(fft(a)) .*fft(w) ));


dist = @(w) norm(x_0 - exp(-1i*angle(x_0'*w))*w)/norm(x_0);
func_val = @(w) 1/(2*m)* sum( (y -  abs(func_Az(w))).^2  ) ; 
z = z_0;


for k = 1:opts.MaxIter
    Az = func_Az(z);
    Az_abs = abs(Az);
    f_old = 1/(2*m) * sum((y - Az_abs).^2);
    
    ind = (Az_abs~=0);
    Grad = Az - y .* ( (Az./Az_abs).*ind + 1.*(~ind)  );
    Grad = func_Az_1(Grad);
    Grad = Grad(1:n);
    norm_Grad = norm(Grad)/(2*m);
%     backtracking linesearch
    tau = 1;
    count = 1;
    while( f_old<=  func_val( z - tau*Grad ) + 0.9*tau*norm_Grad && count<=20 )
           tau = tau*0.5;
           count = count+1;
           if(count>=20)
               break;
           end
    end
    
     z = z - tau * Grad;
%      f_val = func_val(z);
    err =  dist(z);
%     f_err = abs(f_old - f_val);
    
    if(opts.isprint == 1)
        fprintf('Iter = %d, Err = %f\n',k,err);
    end
    if(err <= opts.tol )
        break;
    end
end

end