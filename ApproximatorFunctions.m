classdef ApproximatorFunctions < matlab.mixin.Copyable & handle
    
    
    
    properties (SetAccess = protected)

    end
    
    properties (SetAccess = private)
      
    end
    
   
    methods (Access=public)
        function obj = ApproximatorFunctions()          
            %obj.mdp = mdp;             
        end

                  
        function [q_approx] = Q_Approximator(obj,dealer, player_score,weight)
            
           %approximated Q function when a=HIT
           
           features_HIT =obj.Q_features(dealer, player_score, 1);
           
           q_approx_HIT = features_HIT' * weight;
           
           %approximated Q function when a=HIT
           
           features_STICK = obj.Q_features(dealer, player_score, 2);
            
            
           q_approx_STICK = features_STICK' * weight;
           
           q_approx = [q_approx_HIT, q_approx_STICK];
            
        end
              
        
        
        
        function result = Q_features(obj, d0, player_score, action)

        result = zeros(3,6,2);
        pos_x = [];
        pos_y = [];

        if (d0>=1 && d0<=4)
            pos_x(end+1) = 1;
        end

        if (d0>=4 && d0<=7)
            pos_x(end+1) = 2;
        end

        if (d0>=7 && d0<=10)
            pos_x(end+1) = 3;
        end

        %for position y:

        if (player_score>=1 && player_score<=6)
            pos_y(end+1) = 1;
        end

        if (player_score>=4 && player_score<=9)
            pos_y(end+1) = 2;
        end

        if (player_score>=7 && player_score<=12)
            pos_y(end+1) = 3;
        end

        if (player_score>=10 && player_score<=15)
            pos_y(end+1) = 3;
        end

        if (player_score>=13 && player_score<=18)
            pos_y(end+1) = 3;
        end

        if (player_score>=16 && player_score<=21)
            pos_y(end+1) = 3;
        end

        pos_z = action;

        for i=1:length(pos_x)
            for j=1:length(pos_y)
                result(pos_x(i),pos_y(j),pos_z) = 1;
            end
        end

        result = reshape(result,36,1);


        end
            
            
        
        
        
        
        
        
        
        
        %incorrect here - check update_features again
        function [Phi] = update_features(obj, state)
            
            dealerCard = state(1);
            playerCard = state(2);
            
            dealer_Phi = [];
            player_Phi = [];
            
            feature_dealer = [1:10];
            feature_player = [1:21];
            
            for i = 1:length(feature_dealer)
                
                if dealerCard == feature_dealer(i)
                    
                    dealer_Phi = [dealer_Phi, 1];
                else
                    dealer_Phi = [dealer_Phi, 0];
                    
                end
                
            end
            
            
            for j = 1:length(feature_player)
                if playerCard == feature_dealer(i)
                    
                    player_Phi = [player_Phi, 1];
                else
                    player_Phi = [player_Phi, 0];
                    
                end
                
            end
            
            features = [1:18];
            
            for k = 1:length(features)
                j = floor(k/length(feature_player));
                
                h = mod(k, length(feature_player));
                
                Phi(k) = dealer_Phi(j) * player_Phi(h);
                
            end
              
        end
                    
    end
    
    
end




       



       