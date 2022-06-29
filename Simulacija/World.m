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
            
            n = length(obj.dpls);
            
            for i = 1:n
                obj.dpls(i).pos = obj.dpls(i).pos + obj.dpls(i).vel*dt + 0.5*obj.dpls(i).acc*dt*dt;
            end
            
            new_accs = zeros(n, 3);
            
            %HERE SHOULD NE A FUNCTION FOR CALCULATING NEW ACCELERATIONG
            %BASED ON MAGNETIC FIELD, DIPOLE-DIPOLE INTERACTIONS AND
            %LENNARD-JONES POTENTIAL
            for i = 1:n
                new_accs(i, 1) = obj.dpls(i).acc(1);
                new_accs(i, 2) = obj.dpls(i).acc(2);
                new_accs(i, 3) = obj.dpls(i).acc(3);
            end
            
            for i = 1:n
                new_acc = [new_accs(i, 1), new_accs(i, 2), new_accs(i, 3)];
                obj.dpls(i).vel = obj.dpls(i).vel + 0.5*(obj.dpls(i).acc + new_acc)*dt;
                obj.dpls(i).acc = new_acc;
            end
            
            %WARNING: THIS FUNCTION CURENTLY ONLY UPDATES TIME, POSITION
            %AND VELOCITY
            
            obj.time = obj.time + dt;
            
            this = obj;
        end
        
        function data = run_sim(obj, dt, n)
            obj = obj.init_sim(); %initialize all of the forces at t = 0
            
            data = struct; %memorizing all of the data created by 
            %simulation in one struct (this includes every dipole at
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

