classdef Dipole
    %This class represents dipole in physical world
    %it's defined by it's magnetic dipole moment
    %and holds info about it's transformation and velocity
    
    properties
        moment
        position
        orientation
        velocity = [0 0 0]
        radius = 1
    end
    
    methods
        function obj = Dipole(moment, position, orientation)
            obj.moment = moment;
            obj.position = position;
            obj.orientation = orientation;
        end
        
        function speed = get_speed(obj)
            speed = vec_intensity(obj.velocity);
        end
    end
end