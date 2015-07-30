classdef MDP < handle
    
    properties(Access = public, Constant)

    end
    
    properties(SetAccess = protected, GetAccess = public)

         name;

    end
    
    methods(Access = public)
        
            
            function obj = MDP(name);
             obj.name = name;
            end

    end
    
    
        methods(Access = public, Abstract)

        reward(obj, state, action);
        getStartState(obj);

    end
    
    methods(Access = protected, Abstract)

    end
    
    
end


