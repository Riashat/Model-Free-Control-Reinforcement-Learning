function [opt_value] = MonteCarloControl(agent, mdp, dealer, player, action, episode, N)

ActionValue = zeros(action, dealer, player);
NumberState = zeros(dealer, player);
NumberStateAction = zeros(action, dealer, player);


for i = 1:episode
    
    %get start state from MDP
    [state] = mdp.getStartState;
    reward=-2;

    dealerCard = state(1);
    playerCard = state(2);
    
     while (reward==-2)
         
        %update epsilon
        epsilon = N/ (N + NumberState(dealerCard, playerCard));
        
        %epsilon-greedy policy implemented in agent class
        action = agent.epsilon_greedy_policy(ActionValue, state, epsilon);
        
        %update N(s) and N(a,s)
        NumberState(dealerCard, playerCard) = NumberState(dealerCard, playerCard) + 1;
        NumberStateAction(action,dealerCard, playerCard) = NumberStateAction(action, dealerCard, playerCard) + 1;
        
        %take an action, and get the reward from the MDP
        [successorState, reward] = mdp.step(state, action);
        
        newState = successorState;
        
      if (reward ~=-2) %when the match is over  
            step_size = 1/ NumberStateAction(action, dealerCard, playerCard);        
            ActionValue(action, dealerCard, playerCard) = ActionValue(action, dealerCard, playerCard) + step_size * (reward - ActionValue(action, dealerCard, playerCard));      
            ActionValue(action, dealerCard, playerCard);
      end 
        
        
        playerCard = newState;   
        state = [dealerCard, playerCard];
        
     end    

end

opt_value = ActionValue;


        