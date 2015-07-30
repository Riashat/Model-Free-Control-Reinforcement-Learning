function [mse] = Q3_runSarsa()

fprintf('Running Sarsa Algorithm on Easy 21 Game')

lambda = 0:0.1:1;
iteration = 1000;

mse = zeros(length(lambda),1);

for i = 1:length(lambda)

mse(i) = Sarsa(lambda(i), iteration);

end

%plot for lambda = 0 and lamba=1 only


length(mse);
figure(1)
title('Sarsa - Mean Squared Error vs Lambda')
plot((0:0.1:1), mse)
xlabel('Lambda')
ylabel('Mean Squared Error')
grid on

end