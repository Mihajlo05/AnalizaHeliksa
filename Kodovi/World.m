classdef World
    %WORLD represents all of space in real world
    %You can add dipoles and magnetic fields to
    %the world
    
    properties
        dipoles = []
        time = 0
        
        dip_radius = 1;
        dip_moment = 1;
    end
    
    methods
        function this = update(obj, dt)
            for i = 1:length(obj.dipoles)
               obj.dipoles(i) = obj.dipoles(i).update(dt); 
            end
            
            obj.time = obj.time + dt;
            
            this = obj;
        end
        
        function data = run_simulation(obj, dt, n)
            data = struct;
            
            data.dipoles = obj.dipoles;
            data.time = obj.time;
            
            for i = 1:n
                obj = obj.update(dt);
                
                data.dipoles = [data.dipoles, obj.dipoles];
                data.time = [data.time, obj.time];
            end
            
            data.dip_radius = obj.dip_radius;
            data.dip_moment = obj.dip_moment;
        end
    end
end

