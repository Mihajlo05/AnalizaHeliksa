classdef World
    %WORLD represents all of space in real world
    %You can add dipoles and magnetic fields to
    %the world
    
    properties
        dpls = [] %dipoles
        time = 0
        
        dpl_r = 1; %radius of dipoles
        dpl_moment = 1; %magnetic moment of dipoles
        dpl_mass = 1; %mass of dipoles
    end
    
    methods
        function this = init_sim(obj)
            %this function calculates all of the forces at t = 0
            %call this before calling first update on the world
            
            %WARNING: THIS FUNCTION CURRENTLY DOES NOTHING
            
            this = obj;
        end
        
        function this = update(obj, dt)
            %UPDATE ALL OF THE POSITIONS, VELOCITIES, ACCELERATIONS,
            %ROTATIONS, ANGULAR VELOCITIES and ANGULAR ACCELERATIONS
            
            %WARNING: THIS FUNCTION CURENTLY ONLY UPDATES TIME, AND NONE OF
            %THE ABOVE
            
            obj.time = obj.time + dt;
            
            this = obj;
        end
        
        function data = run_sim(obj, dt, n)
            obj = obj.init_sim(); %initialize all of the forces at t = 0
            
            data = struct; %memorizing all of the data created by 
            %simulation in one struct (this includes every dipoles at
            %each point in time, basically memorizing all of the history
            %of the world)
            
            data.dpls = obj.dpls;
            data.time = obj.time;
            
            for i = 1:n
                obj = obj.update(dt);
                
                data.dpls = [data.dpls, obj.dpls];
                data.time = [data.time, obj.time];
            end
            
            data.dpl_r = obj.dpl_r;
            data.dpl_moment = obj.dpl_moment;
        end
    end
end

