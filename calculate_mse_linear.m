function result = calculate_mse_linear(w)

load('Q_function.mat')
Q_MC = Q_function;
function_approximator = FunctionApproximator();


Q_Approx = zeros(2,10,21);

for i=1:2
    for j=1:10
        for k=1:21
            feature_vector = function_approximator.Q_features(j,k,i);
            Q_Approx(i,j,k) = feature_vector'*w;
        end
    end
end

result = sum(sum(sum((Q_MC - Q_Approx).^2)));


end
