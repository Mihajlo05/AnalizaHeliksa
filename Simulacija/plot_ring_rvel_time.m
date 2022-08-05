function plot_ring_rvel_time(data, Nr)
    Nd = data.n_dpls / Nr;
    
    RVels = zeros(Nr, length(data.time));
    Rots = zeros(Nr, length(data.time));
    
    DStarts(1:Nr) = Dipole;
    
    for j = 1:Nr
        DStarts(j) = data.dpls((j-1)*Nd + 1, 1);
    end
    
    for i = 1:length(data.time)
        for j = 1:Nr
            d = data.dpls((j-1)*Nd + 1, i);
            
            r = d.pos;
            R = sqrt(sum(r.^2, 'all'));
            
            RVels(j, i) = sqrt(sum(d.vel.^2, 'all')) / R;
            
            crsVel = cross(d.pos, d.vel);
            
            RVels(j, i) = sign(crsVel(3)) * RVels(j, i);
            
            rStart = DStarts(j).pos;
            
            cosTheta = max(min(dot(rStart,r)/(norm(rStart)*norm(r)),1),-1);
            Rots(j, i) = real(acosd(cosTheta));
            
            crsRot = cross(rStart, rStart - r);
            Rots(j, i) = sign(crsRot(3)) * Rots(j, i);
        end
    end
    
    figure;
    hold on;
    grid on;
    
    title("Zavisnost brzine rotacije prstena od vremena");
    xlabel("Vreme");
    ylabel("Brzina rotacije");
    
    for j = 1:Nr
        plot(data.time, RVels(j, :));
    end
    
    figure;
    hold on;
    grid on;
    
    title("Zavisnost rotacije prstena od vremena");
    xlabel("Vreme");
    ylabel("Ugao");
    
    for j = 1:Nr
        plot(data.time, Rots(j, :));
    end
end

