function plot_energyd_time(data, option)
    n = length(data.time) - 1;
    dpl_energies = zeros(1, n/100);
    ts = zeros(1, n/100);
    
    for i = 1:(n/100)
        wt = World;
        wt.dpls = data.dpls(:, i*100);
        wt.B = data.B;
        
        ts(i) = data.time(i*100);
        
        dpl_energies(i) = wt.net_dpl_U() / data.n_dpls;
    end
    
    plot(ts, dpl_energies, option);
    grid on;
    
    title("Zavisnost energije dipol-dipol interakcije od vremena");
    xlabel("Vreme");
    ylabel("Energija");
end

