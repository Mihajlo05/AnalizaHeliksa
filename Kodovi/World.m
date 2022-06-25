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
        
        function ob = add_dipole(obj, dip)
            obj.dipoles = [obj.dipoles, dip];
            ob = obj;
        end
    end
end

