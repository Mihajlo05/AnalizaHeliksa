classdef Dipole
    %This class represents dipole in physical world
    %it's defined by it's magnetic dipole moment
    %and holds info about it's transformation and velocity
    
    properties
        moment
        position
        orientation
        velocity = [0 0 0]
        %Seperated angular speed and direction
        %instead of using a vector whose intensity i it's speed
        %because of some quaternion stuff and optimisation
        angular_speed = 0
        angular_vel_dir = [1 0 0]
        radius = 1
    end
    
    methods
        function obj = Dipole(moment, position, orientation)
            obj.moment = moment;
            obj.position = position;
            obj.orientation = orientation;
        end
        
        function this = update(obj, dt)
            obj.position = obj.position + obj.velocity * dt;
            
            q = rot_quat(obj.angular_vel_dir, obj.angular_speed * dt);
            obj.orientation = rotatepoint(q, obj.orientation);
            
            this = obj;
        end
    end
end