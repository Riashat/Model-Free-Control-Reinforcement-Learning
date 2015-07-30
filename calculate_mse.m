function mse = calculate_mse(Q_Function)

load('Q_function.mat')
True_Q = Q_function;
% True_Q = opt_value;

mse = sum(sum(sum((True_Q - Q_Function).^2)));

end

