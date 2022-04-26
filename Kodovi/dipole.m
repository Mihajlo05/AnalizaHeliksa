classdef dipole
    %This class represents dipole in physical world
    %it's defined by it's magnetic dipole moment
    %and holds info like it's position and velocity
    
    properties
        moment
        position
        velocity = [0, 0, 0]
    end
    
    methods
        function obj = dipole(moment, position)
            obj.moment = moment;
            obj.position = position;
        end
    end
end

