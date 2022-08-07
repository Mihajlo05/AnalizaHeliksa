function BData = get_BData(B0, dB, dt, nSim, itersPerSim, w)
    BData = struct;
    
    BData.n_dpls = length(w.dpls);
    
    BData.dpls(1:BData.n_dpls, 1:nSim) = Dipole;
    BData.Bs = zeros(1, nSim);
    BData.lastIts = zeros(1, nSim);
    
    BData.dpl_r = w.dpl_r;
    BData.dpl_moment = w.dpl_moment;
    BData.dpl_mass = w.dpl_mass;
    BData.e = w.e;
    
    curB = B0;
    
    for i = 1:nSim
        disp("SIM: " + string(i) + "/" + string(nSim));
        
        w.B = [0 0 curB];
        BData.Bs(i) = curB;
        curB = curB + dB;
        
        [data, lastIt] = w.simulate(dt, itersPerSim);
        
        if lastIt ~= itersPerSim + 1
            for j = 1:BData.n_dpls
                BData.dpls(j, i) = data.dpls(j, lastIt);
            end
        else
            lowestE = 10000;
            lowestEIt = 0;
            
            for j = 4500:50:itersPerSim
                wt = World;
                wt.dpls = data.dpls(:, j);
                E = wt.net_dpl_U();
                if E < lowestE
                    lowestE = E;
                    lowestEIt = j;
                end
            end
            
            for j = 1:BData.n_dpls
                BData.dpls(j, i) = data.dpls(j, lowestEIt);
            end
        end
        
        BData.lastIts(i) = lastIt;
    end
end

