classdef World
    %WORLD represents all of space in real world
    %You can add dipoles and magnetic fields to
    %the world
    
    properties
        dipoles = []
        time = 0
    end
    
    methods
        function this = update(obj, dt)
            for i = 1:length(obj.dipoles)
               obj.dipoles(i) = obj.dipoles(i).update(dt); 
            end
            
            obj.time = obj.time + dt;
            
            this = obj;
        end
    end
end

