function plot_ring_rvel_B(BData, Nr)
    Nd = BData.n_dpls / Nr;
    
    Rots = zeros(Nr, length(BData.Bs));
    
    DStarts(1:Nr) = Dipole;
    
    for j = 1:Nr
        DStarts(j) = BData.dpls((j-1)*Nd + 1, 1);
    end
    
    for i = 1:length(BData.Bs)
        for j = 1:Nr
            d = BData.dpls((j-1)*Nd + 1, i);
            
            r = d.pos;
            
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
    
    title("Zavisnost rotacije prstena od Magnetne indukcije");
    xlabel("Magnetna indukcija");
    ylabel("Ugao [rad]");
    
    for j = 1:Nr
        plot(BData.Bs, Rots(j, :));
    end
end
