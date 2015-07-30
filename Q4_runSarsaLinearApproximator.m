
function [mse] = Q4_runSarsaLinearApproximator()

fprintf('Running Sarsa With Linear Function Approximation on Easy 21 Game')

lambda = 0:0.1:1;
iteration = 1000;

mse = zeros(length(lambda),1);

for i = 1:length(lambda)


mse(i) = Sarsa_LinearFunctionApproximator(lambda(i), iteration);

end


length(mse);
figure(1)
plot((0:0.1:1), mse)
title('Sarsa Linear Function Approximation - Mean Squared Error vs Lambda')
xlabel('Lambda')
ylabel('Mean Squared Error')
grid on


end