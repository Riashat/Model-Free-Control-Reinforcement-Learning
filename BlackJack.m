classdef BlackJack < MDP 
    
    properties(SetAccess = private)        
    end
    
    methods(Access = public)       
        function obj = BlackJack()            
            name = 'BlackJack';           
            obj = obj@MDP(name);
        end
        
  
        function rwd = reward(obj, state, action)
        end
            
        
        function [start_state] = getStartState(obj)
        %start_state = both players should draw a black card at the start of the
        %MDP        
        start_state = [randi(10) randi(10)];

        end

        
        
        %STEP FUNCTION DEFINED HERE
        function [successorState, reward] = step(obj, state, action)
                    
            dealerSumTotal = state(1);
            playerSum = state(2);
            
            HIT = 1;
            STICK = 2;

            %initial check to see if player has already lost or not
        if (playerSum < 1 || playerSum > 21) %player has already lost, dealer Won
            reward = -1;
            successorState = playerSum;
                
        else %player has not lost - 
                                     
            if (action == HIT)
                playerSum = playerSum + obj.drawDeckCard();          
                %player_bust = obj.check_burst(playerSum);
                
                if (playerSum < 1 || playerSum > 21)
                    reward = -1;
                    successorState = playerSum;
                else
                    reward = -2;
                    successorState = playerSum;
                end
                
                
            else%meaning, Dealer's turn now
                dealerSum = obj.dealers_Draw(dealerSumTotal);
    
                if (dealerSum < 1|| dealerSum > 21)             
                    reward = 1;
                    successorState = playerSum;
                    
                else                  
                    if dealerSum == playerSum
                        successorState = playerSum;
                        reward = 0;
                    elseif dealerSum > playerSum
                        reward = -1; %dealer Won, player loses
                        successorState = playerSum;
                    else
                        %when player has won
                        reward = 1;
                        successorState = playerSum;
                        
                    end
                end
            end
        end
                
                
        end
        
        
        
        function dealer_sum = dealers_Draw(obj,dealer_card)

                dealer_sum = dealer_card;
    
        while(dealer_sum<17 && dealer_sum>0)  %changed here
               dealer_sum = obj.drawDeckCard + dealer_sum;
        end

        end
        
        
        
        function red = drawRed(obj)
            red = - randi(10);       
        end
        
        
        
        function black = drawBlack(obj)
            black = randi(10);
        end
          
        
        
        function new_card = drawDeckCard(obj)
            card = randi(3);
            if (card == 1)
             card = -1;
            else
             card = 1;
            end
    
             new_card = card*randi(10);
        end
        
        
        
        
        function burst = check_burst(obj,score)
            if score < 1 || score > 21
                burst = 1;
            else
                burst = 0;
            end
        end
        
        
        
        function burst = check_dealer_burst(obj,score)
            if score >= 1 || score <= 21
                burst = 0;
            else
                burst = 1;
            end
        end
        
        
    end
        
    
    
    
    methods(Access = private)
        
              
    end
end