classdef Dipole
    %This class represents dipole in physical world
    %it's defined by it's magnetic dipole moment
    %and holds info about it's transformation and velocity
    
    properties
        pos
        %FORGET ABOUT ROTATION FOR NOW
        vel = [0 0 0]
        ang_vel = [0 0 0]
        acc = [0 0 0]
        ang_acc = [0 0 0]
    end
    
    methods
        function obj = Dipole(pos)
            obj.pos = pos;
        end
    end
end