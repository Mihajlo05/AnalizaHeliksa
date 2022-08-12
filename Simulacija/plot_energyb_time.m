function plot_energyb_time(data, option)
    n = length(data.time) - 1;
    
    c = 1;
   
    B_energies = zeros(1, n/c);
    ts = zeros(1, n/c);
    
    for i = 1:(n/c)
        wt = World;
        wt.dpls = data.dpls(:, i*c);
        wt.B = data.B;
        
        ts(i) = data.time(i*c);
        
        B_energies(i) = wt.net_B_U() / data.n_dpls;
    end
    
    plot(ts, B_energies, option);
    grid on;
    
    title("Zavisnost energije interakcije sa magnetnim poljem od vremena");
    xlabel("Vreme");
    ylabel("Energija");
end

