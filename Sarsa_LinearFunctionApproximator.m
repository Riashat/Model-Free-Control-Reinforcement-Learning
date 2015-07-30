function [mse] = Sarsa_LinearFunctionApproximator(lambda, episode)

mdp = BlackJack ();
agent = Agent(mdp);
error =[];
function_approximator = FunctionApproximator();

%weight vector
w = zeros(36,1);
succ_action=0;

for i = 1:episode
    
    eligibility = 0;
    
    [state] = mdp.getStartState;
    
    dealerCard = state(1);
    playerCard = state(2);
     
    reward=-2;
    
    %approximate the action-value function using the weights
    ActionValue = function_approximator.Q_Approximator(dealerCard, playerCard, w);
    
    e_greedy = 0.05;
    greedy = (e_greedy/2) + 1 - e_greedy; %for higher Q value actions
    nongreedy = (e_greedy/2);              %for lower Q value actions
    
    [policy_greedy, policy_nongreedy] = agent.greedy_policy_linearApprox(ActionValue);
    action = agent.greedy_linearApproxAction(greedy, nongreedy, policy_greedy, policy_nongreedy);
    
      
    while reward==-2
               
        [successorState, reward] = mdp.step(state, action);    
        nextState = successorState;
        reward = reward;
        
        ActionValue = function_approximator.Q_Approximator(dealerCard, playerCard, w);
        
        if reward == -2
           
           %get the updated Q function
           Succ_ActionValue = function_approximator.Q_Approximator(dealerCard, nextState, w);
           [policy_greedy, policy_nongreedy] = agent.greedy_policy_linearApprox(Succ_ActionValue);
           succ_action = agent.greedy_linearApproxAction(greedy, nongreedy, policy_greedy, policy_nongreedy);
        
           %no immediate Rewards in Easy21 - so delta = Q(a') - Q(a)
           delta = Succ_ActionValue(succ_action) - ActionValue(action);
           
        else
            %when the match is finished 
            %delte = R + 0 - Q(a)
            delta = reward - ActionValue(action);
        end
        
        eligibility = lambda * eligibility + function_approximator.Q_features(dealerCard, playerCard, action);        
        step_size = 0.01;        
        grad_w = step_size * delta * eligibility;
        
        w = w + grad_w;
         
        
        playerCard = nextState;
        action = succ_action;       
        state = [dealerCard, playerCard];        
    end
     
        if lambda == 0 || lambda == 1
            error_mse = calculate_mse_linear(w);
            error(end+1) = error_mse;
        end   
end

mse = calculate_mse_linear(w);
            
    if lambda == 0
        figure(2)  
        plot((1:1000),error)
        title('Sarsa Linear Approximation Learning Curve For Lambda=0')
        xlabel('Episode Number')
        ylabel('Mean Squared Error')   
        grid on
    end
    if lambda == 1
        figure(3)
        plot((1:1000),error)
        title('Sarsa Linear Approximation Learning Curve For Lambda=1')
        xlabel('Episode Number')
        ylabel('Mean Squared Error')    
        grid on
    end

        
        
        
    
    
end






