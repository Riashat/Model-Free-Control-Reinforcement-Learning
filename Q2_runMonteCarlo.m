function [Q_fuction] = Q2_runMonteCarlo()

%set up the BlackJack MDP here
mdp = BlackJack ();

%set up the Player/Agent class here
agent = Agent(mdp);

%defining parameters here
%ActionValue - [state], action
dealer = 10;
player = 21;
action = 2;
episode = 1000000;          %1million episodes
N = 100;

fprintf('Running Monte Carlo on Easy 21 Game')

[Q_fuction] = MonteCarloControl(agent, mdp, dealer, player, action, episode, N);

Q_HIT = zeros(10,21);
Q_STICK = zeros(10,21);
OPTIMAL_VALUE_FUNCTION = zeros(10,21);

% plot for hit 
for i=1:10
    for j=1:21
        Q_HIT(i,j) = Q_fuction(1,i,j);
    end
end

figure(1)
surf(Q_HIT);
title('Plot of Q(s,a) for a=HIT')

% plot for stick
for i=1:10
    for j=1:21
        Q_STICK(i,j) = Q_fuction(2,i,j);
    end
end

figure(2)
surf(Q_STICK);
title('Plot of Q(s,a) for a=STICK')



% plot value function
for i=1:10
    for j=1:21
        OPTIMAL_VALUE_FUNCTION(i,j) = max(Q_fuction(:,i,j));
    end
end

figure(3)
surf(OPTIMAL_VALUE_FUNCTION);
title('Plot of Optimal Value Function - V* (s)')


save 'Results.mat'

end