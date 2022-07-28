classdef Dipole
    %This class represents dipole in physical world
    %it's defined by it's magnetic dipole moment
    %and holds info about it's transformation and velocity
    
    properties
        pos = [0 0 0]
        vel = [0 0 0]
        acc = [0 0 0]
        ori = [0 0 0]
        ang_vel = [0 0 0]
        ang_acc = [0 0 0]
    end
    
    methods
        function obj = Dipole()
        end
    end
    
    methods(Static)
        %Generate a dipole in cetner of coord system [0 0 0] and whose
        %magnetic moment is pointing up [0 0 1] (in positive z direction)
        function obj = default()
            obj = Dipole();
        end
    end
end