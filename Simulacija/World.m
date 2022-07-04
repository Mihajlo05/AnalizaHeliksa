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
        e = 0.02 %depth of the potential well in lennard-jones potential
        
        mu0 = 1.25663706 %permeability of free space
    end
    
    methods
        function [force1, force2] = lj_force(obj, dpl1, dpl2)
            r = dpl2.pos - dpl1.pos;
            dist = sqrt(sum(r.^2, 'all'));
            dir = r / dist;
            
            rad = 2*obj.dpl_r;
            
            if dist < (2^(1/6))*rad
                F = 4*obj.e*( 12*(rad^12)/dist^13 + 6*(rad^6)/dist^7);
                force1 = -F*dir;
                force2 = F*dir;
            else
                force1 = [0 0 0];
                force2 = [0 0 0];
            end
        end
        
        function [force1, force2] = dpl_dpl_force(obj, dpl1, dpl2)
            r = dpl2.pos - dpl1.pos;
            dist = sqrt(sum(r.^2, 'all'));
            
            k = (3*obj.mu0)/(4*pi*dist^4);
            
            m1 = dpl1.ori * obj.dpl_moment;
            m2 = dpl2.ori * obj.dpl_moment;
            
            rxm1 = cross(r, m1);
            rxm2 = cross(r, m2);
            m1_dot_m2 = dot(m1, m2);
            rxm1_dot_rxm2 = dot(rxm1, rxm2);
            
            force1 = k*(dot(rxm1, m2) + dot(rxm2, m1) - 2*r*m1_dot_m2 + 5*r*rxm1_dot_rxm2);
            force2 = -force1;
        end
        
        function [new_accs, new_ang_accs] = calc_forces(obj)
            n = length(obj.dpls);
            
            new_accs = zeros(n, 3);
            new_ang_accs = zeros(n, 3);
            
            for i = 1:n
                for j = (i+1):n
                    [lj1, lj2] = obj.lj_force(obj.dpls(i), obj.dpls(j));
                    [dp1, dp2] = obj.dpl_dpl_force(obj.dpls(i), obj.dpls(j));
                    
                    
                    for k = 1:3
                        new_accs(i, k) = new_accs(i, k) + (lj1(k))/obj.dpl_mass;
                        new_accs(j, k) = new_accs(j, k) + (lj2(k))/obj.dpl_mass;
                    end
                end
                
                for k = 1:3
                    new_ang_accs(i, k) = obj.dpls(i).ang_acc(k);
                end
            end
        end
        
        function this = update(obj, dt)
            %UPDATE ALL OF THE POSITIONS, VELOCITIES, ACCELERATIONS,
            %ROTATIONS, ANGULAR VELOCITIES and ANGULAR ACCELERATIONS
            
            n = length(obj.dpls);
            
            for i = 1:n
                pos = obj.dpls(i).pos;
                vel = obj.dpls(i).vel;
                acc = obj.dpls(i).acc;
                
                obj.dpls(i).pos = pos + vel*dt + 0.5*acc*dt*dt;
                
                ori = obj.dpls(i).ori;
                avel = obj.dpls(i).ang_vel;
                aacc = obj.dpls(i).ang_acc;
                
                q = quaternion(avel*dt + 0.5*aacc*dt*dt, 'rotvec');
                
                obj.dpls(i).ori = rotatepoint(q, ori);
            end
            
            [new_accs, new_ang_accs] = obj.calc_forces();
            
            for i = 1:n
                new_acc = [new_accs(i, 1), new_accs(i, 2), new_accs(i, 3)];
                acc = obj.dpls(i).acc;
                vel = obj.dpls(i).vel;
                
                obj.dpls(i).vel = vel + 0.5*(acc + new_acc)*dt;
                obj.dpls(i).acc = new_acc;
                
                new_aacc = [new_ang_accs(i, 1), new_ang_accs(i, 2), new_ang_accs(i, 3)];
                aacc = obj.dpls(i).ang_acc;
                avel = obj.dpls(i).ang_vel;
                
                obj.dpls(i).ang_vel = avel + 0.5*(aacc + new_aacc)*dt;
            end
            
            obj.time = obj.time + dt;
            
            this = obj;
        end
        
        function data = simulate(obj, dt, n)
            [accs, ang_accs] = obj.calc_forces();
            
            for i = 1:length(obj.dpls)
                for k = 1:3
                    obj.dpls(i).acc(k) = accs(i, k);
                    obj.dpls(i).ang_acc(k) = ang_accs(i, k);
                end
            end
            
            data = struct; %memorizing all of the data created by 
            %simulation in one struct (this includes every dipole at
            %each point in time, basically memorizing all of the history
            %of the world)
            
            data.n_dpls = length(obj.dpls);
            data.dpls = obj.dpls;
            data.time = obj.time;
            
            for i = 1:n
                obj = obj.update(dt);
                
                data.dpls = [data.dpls, obj.dpls];
                data.time = [data.time, obj.time];
            end
            
            data.dpl_r = obj.dpl_r;
            data.dpl_moment = obj.dpl_moment;
            data.dpl_mass = obj.dpl_mass;
            data.e = obj.e;
        end
    end
end

