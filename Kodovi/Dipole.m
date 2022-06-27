classdef Dipole
    %This class represents dipole in physical world
    %it's defined by it's magnetic dipole moment
    %and holds info about it's transformation and velocity
    
    properties
        position
        orientation
        vel = [0 0 0]
        ang_vel = [0 0 0]
    end
    
    methods
        function obj = Dipole(position, orientation)
            obj.position = position;
            obj.orientation = orientation;
        end
        
        function this = update(obj, dt)
            obj.position = obj.position + obj.vel * dt;
            
            q = quaternion(obj.ang_vel * dt, 'rotvec');
            obj.orientation = rotatepoint(q, obj.orientation);
            
            this = obj;
        end
    end
end