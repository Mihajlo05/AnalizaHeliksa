function plot_energyb_time(data, option)
    n = length(data.time) - 1;
    B_energies = zeros(1, n/100);
    ts = zeros(1, n/100);
    
    for i = 1:(n/100)
        wt = World;
        wt.dpls = data.dpls(:, i*100);
        wt.B = data.B;
        
        ts(i) = data.time(i*100);
        
        B_energies(i) = wt.net_B_U() / data.n_dpls;
    end
    
    plot(ts, B_energies, option);
    grid on;
    
    title("Zavisnost energije interakcije sa magnetnim poljem od vremena");
    xlabel("Vreme");
    ylabel("Energija");
end

