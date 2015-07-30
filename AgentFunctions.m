classdef AgentFunctions < matlab.mixin.Copyable & handle
    properties (SetAccess = protected)

    end
    
    properties (SetAccess = private)
      mdp;
    end
    
   
    methods (Access=public)
        function obj = AgentFunctions(mdp)          
            obj.mdp = mdp;             
        end

        %defining the greedy_policy here
        %greedy policy used in Monte Carlo Control        
        function action = epsilon_greedy_policy(obj, ActionValue, state, epsilon)
        
            hit=1;  stick=2;
            
            dealerCard = state(1);
            playerCard = state(2);
            
            greedy_prob = (epsilon/2) + 1 - epsilon;
            non_greedy_prob = epsilon/2;
            
            Q_HIT = ActionValue(hit,dealerCard, playerCard);
            Q_STICK = ActionValue(stick,dealerCard, playerCard);
            
            if Q_HIT > Q_STICK
                greedy_policy = 1;  %choose HIT=1 greedily
                nongreedy_policy =2;
                
            elseif Q_HIT < Q_STICK
                greedy_policy =2;   %choose STICK=2 greedily
                nongreedy_policy = 1;
            
            else %when Q_HIT=Q_STICK
                
                %choose a greedy policy randomly
                greedy_policy = randi(2);
                
                if greedy_policy==1
                    nongreedy_policy=2;
                else
                    nongreedy_policy = 1;
                end
            end
           
            probability = sum(rand() >= cumsum([0, greedy_prob, non_greedy_prob]));
            
            
            if (probability ==1)
                action = greedy_policy;
                
            else
                action = nongreedy_policy;       
            end
        
        end
            

              
        function [greedy, nongreedy] = greedy_policy_linearApprox(obj,ActionValue)

            %for HIT 
            if ActionValue(1) > ActionValue(2)
                greedy=1;
                nongreedy=2;
                
            elseif ActionValue(1) < ActionValue(2)
                greedy=2;
                nongreedy=1;
                
            else
                greedy = randi(2);
                if greedy==1
                    nongreedy=2;
                else
                    nongreedy=1;
                end
            end
        end
        
        
        function [action] = greedy_linearApproxAction(obj, greedy_policy, non_greedy_policy, policy_greedy_action, policy_nongreedy_action)
          p = sum(rand() >= cumsum([0, greedy_policy, non_greedy_policy]));

          if (p==1)   %greedy action should be taken
            action = policy_greedy_action;
          else        %not greedy action should be taken
            action = policy_nongreedy_action;
         end  
                    
        end
        
        
    end
    
    
end




       