function plot_energyd_time(data, option)
    n = length(data.time) - 1;
    
    c = 10;
    
    dpl_energies = zeros(1, n/c);
    ts = zeros(1, n/c);
    
    for i = 1:(n/c)
        wt = World;
        wt.dpls = data.dpls(:, i*c);
        wt.B = data.B;
        
        ts(i) = data.time(i*c);
        
        dpl_energies(i) = wt.net_dpl_U() / data.n_dpls;
    end
    
    plot(ts, dpl_energies, option);
    grid on;
    
    title("Zavisnost energije dipol-dipol interakcije od vremena");
    xlabel("Vreme");
    ylabel("Energija");
end

