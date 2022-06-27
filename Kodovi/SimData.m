%All of (useful) data made by simulation, this incules data that change
%with time (ex. position and orientation of dipoles), and those that do not
%change (like magnetic field)
classdef SimData
    properties
        ts_datas
    end
    
    methods
        function obj = SimData(world, dt, n_iterations)
            obj.ts_datas = struct('dipoles', world.dipoles, 'time', world.time);
            for i = 1:n_iterations
                world = world.update(dt);
                obj.ts_datas = [obj.ts_datas, struct('dipoles', world.dipoles, 'time', world.time)];
            end
        end
    end
end

