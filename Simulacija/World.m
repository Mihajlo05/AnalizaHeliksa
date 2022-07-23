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
        e = 0.01 %depth of the potential well in lennard-jones potential
        
        mu0 = 1.25663706 %permeability of free space
    end
    
    methods
        function I = get_dpl_I(obj)
            I = 2*obj.dpl_mass*obj.dpl_r^2 / 5;
        end
        
        function KE = dpl_KE(obj, dpl)
            v = sqrt(sum(dpl.vel.^2, 'all'));
            KE = obj.dpl_mass*v^2 / 2;
        end
        
        function [force1, force2] = lj_force(obj, dpl1, dpl2)
            r = dpl2.pos - dpl1.pos;
            dist = sqrt(sum(r.^2, 'all'));
            dir = r / dist;
            
            sigma = 2*obj.dpl_r;
            
            if dist < (2^(1/6))*sigma
                F = 4*obj.e*( 12*(sigma^12)/dist^13 - 6*(sigma^6)/dist^7);
                force1 = -F*dir;
                force2 = F*dir;
            else
                force1 = [0 0 0];
                force2 = [0 0 0];
            end
        end
        
        function [force1, force2] = dpl_dpl_force(obj, dpl1, dpl2)
            r = dpl1.pos - dpl2.pos;
            dist = sqrt(sum(r.^2, 'all'));
            
            k = (3*obj.mu0)/(4*pi*dist^4);
            
            m1 = dpl1.ori * obj.dpl_moment;
            m2 = dpl2.ori * obj.dpl_moment;
            
            rxm1 = cross(r, m1);
            rxm2 = cross(r, m2);
            m1_dot_m2 = dot(m1, m2);
            rxm1_dot_rxm2 = dot(rxm1, rxm2);
            
            force1 = k*(cross(rxm1, m2) + cross(rxm2, m1) - 2*r*m1_dot_m2 + 5*r*rxm1_dot_rxm2);
            force2 = -force1;
        end
        
        function B = B_from_dpl(obj, dpl, where) %where is in world coords
            m = dpl.ori * obj.dpl_moment;
            k = obj.mu0 / (4*pi);
            r = where - dpl.pos;
            d = sqrt(sum(r.^2, 'all'));
            
            part1 = 3*r*dot(m, r)/d^5;
            part2 = m/d^3;
            
            B = k*(part1 - part2);
        end
        
        function torque = B_dpl_torque(obj, dpl, B)
            m = dpl.ori * obj.dpl_moment;
            torque = cross(m, B);
        end
        
        function [torque1, torque2] = dpl_dpl_torque(obj, dpl1, dpl2)
            B1 = obj.B_from_dpl(dpl1, dpl2.pos);
            B2 = obj.B_from_dpl(dpl2, dpl1.pos);
            
            torque1 = obj.B_dpl_torque(dpl1, B2);
            torque2 = obj.B_dpl_torque(dpl2, B1);
        end
        
        function [new_accs, new_ang_accs] = calc_forces(obj)
            n = length(obj.dpls);
            
            new_accs = zeros(n, 3);
            new_ang_accs = zeros(n, 3);
            
            for i = 1:n
                for j = (i+1):n
                    [lj1, lj2] = obj.lj_force(obj.dpls(i), obj.dpls(j));
                    [dp1, dp2] = obj.dpl_dpl_force(obj.dpls(i), obj.dpls(j));
                    
                    [dt1, dt2] = obj.dpl_dpl_torque(obj.dpls(i), obj.dpls(j));
                    
                    for k = 1:3
                        F1 = lj1(k) + dp1(k);
                        F2 = lj2(k) + dp2(k);
                        
                        T1 = dt1(k);
                        T2 = dt2(k);
                        
                        new_accs(i, k) = new_accs(i, k) + F1/obj.dpl_mass;
                        new_accs(j, k) = new_accs(j, k) + F2/obj.dpl_mass;
                        
                        new_ang_accs(i, k) = new_ang_accs(i, k) + T1/obj.get_dpl_I();
                        new_ang_accs(j, k) = new_ang_accs(j, k) + T2/obj.get_dpl_I();
                    end
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

