function [MSE] = Sarsa(lambda, episode)

%initializing the agent and mdp class
mdp = BlackJack ();
agent = Agent(mdp);

dealer = 10;
player = 21;
action = 2;
error = [];

%initializing Q(s,a)
ActionValue = zeros(action, dealer, player);
NumberState = zeros(dealer, player);
NumberStateAction = zeros(action, dealer, player);
new_action = 0;
num_zero = 100;

%repeat for each episode
for i = 1:episode
    
    %same size as Q(s,a)
    eligibility = zeros(2, 10, 21);
    
    %get start state
    [state] = mdp.getStartState;
    
    dealerCard = state(1);
    playerCard = state(2);
    
    %epsilon needed in sarsa?
    epsilon = num_zero/(num_zero + NumberState(dealerCard, playerCard));

    
    %choose actions according to an epsilon-greedy policy
    %action = agent.greedy_policy(ActionValue, state, epsilon);
    action = agent.epsilon_greedy_policy(ActionValue, state, epsilon);
    reward = -2;
            
    while (reward==-2)
        
        %updating N(s) and N(s,a)
        NumberState(dealerCard, playerCard) = NumberState(dealerCard, playerCard) + 1;
        NumberStateAction(action, dealerCard, playerCard) = NumberStateAction(action, dealerCard, playerCard) + 1;
             
        %take action a, observe r and s'
        [successorState, reward] = mdp.step(state, action);
        
         %new_dealerCard = successorState(1);
         new_playerCard = successorState;
         reward = reward;
                                                                      
        if (reward == -2)
        
        %update the epsilon parameter 
        epsilon = num_zero/ (num_zero + NumberState(dealerCard, new_playerCard));
        
        %take next step action - choose a' from s' using greedy policy
        new_action = agent.epsilon_greedy_policy(ActionValue, state, epsilon);
            
        %update delta at each episode
        delta = ActionValue(new_action, dealerCard, new_playerCard) - ActionValue(action,  dealerCard, playerCard);
              
        else            
         delta = reward - ActionValue(action, dealerCard, playerCard);                
        end
        
        %alpha = step_size
        step_size = 1/ NumberStateAction(action, dealerCard, playerCard);
                      
        %update the eligibility trace
        eligibility(action, dealerCard, playerCard) = eligibility(action, dealerCard, playerCard) + 1;
        
        ActionValue = ActionValue + (step_size*delta).*eligibility;
        eligibility = lambda.*eligibility;

        
        playerCard = new_playerCard;        
        action = new_action;       
        state = [dealerCard, playerCard];
        
    end
    
    %calculating error for lambda=0 and lambda=1 for plotting
    if lambda == 0 || lambda == 1
            error_mse = calculate_mse(ActionValue);
            error(end+1) = error_mse;
    end
    
    
end


%calculate the mean squared error
MSE = calculate_mse(ActionValue);

    if lambda == 0
        figure(2)  
        plot((1:1000),error)
        title('Learning Curve For Lambda=0')
        xlabel('Episode Number')
        ylabel('Mean Squared Error')   
        grid on
    end
    if lambda == 1
        figure(3)
        plot((1:1000),error)
        title('Learning Curve For Lambda=1')
        xlabel('Episode Number')
        ylabel('Mean Squared Error')    
        grid on
    end



end


