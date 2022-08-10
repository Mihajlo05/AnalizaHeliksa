function plot_energy_time(data)
    n = length(data.time) - 1;
    dpl_energies = zeros(1, n/100);
    B_energies = zeros(1, n/100);
    
    for i = 1:(n/100)
        wt = World;
        wt.dpls = data.dpls(:, i*100);
        wt.B = data.B;
        
        dpl_energies(i) = wt.net_dpl_U() / data.n_dpls;
        B_energies(i) = wt.net_B_U() / data.n_dpls;
    end
    
    figure;
    subplot(2, 1, 1);
    
    plot(1:100:n, dpl_energies);
    grid on;
    
    title("Zavisnost energije dipol-dipol interakcije od vremena");
    xlabel("Vreme");
    ylabel("Energija");
    
    subplot(2, 1, 2);
    
    plot(1:100:n, B_energies);
    grid on;
    
    title("Zavisnost energije interakcije sa magnetnim poljem od vremena");
    xlabel("Vreme");
    ylabel("Energija");
end

