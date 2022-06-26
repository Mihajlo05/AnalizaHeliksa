classdef World
    %WORLD represents all of space in real world
    %You can add dipoles and magnetic fields to
    %the world
    
    properties
        dipoles = []
        dt %timestep
        n_iterations
    end
    
    methods
        function obj = World(dt, n_iterations)
            obj.dt = dt;
            obj.n_iterations = n_iterations;
        end
        
        function this = add_dipole(obj, dip)
            obj.dipoles = [obj.dipoles, dip];
            this = obj;
        end
        
        function this = update(obj)
            for i = 1:length(obj.dipoles)
               obj.dipoles(i) = obj.dipoles(i).update(obj.dt); 
            end
            
            this = obj;
        end
        
        function this = run_simulation(obj)
            for i = 1:obj.n_iterations
                obj = obj.update();
            end
            
            this = obj;
        end
    end
end

