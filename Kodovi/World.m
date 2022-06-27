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
        
        function data = run_simulation(obj, dt, n)
            data = struct;
            
            data.time_data = [];
            data.time_data.dipoles = obj.dipoles;
            data.time_data.time = obj.time;
            
            for i = 1:n
                obj = obj.update(dt);
                
                td = struct;
                td.dipoles = obj.dipoles;
                td.time = obj.time;
                
                data.time_data = [data.time_data, td];
            end
        end
    end
end

