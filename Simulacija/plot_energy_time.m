function [B_energies] = plot_energy_time(data)
    n = length(data.time);
    dpl_energies = zeros(1, n);
    B_energies = zeros(1, n);
    
    for i = 1:n
        wt = World;
        wt.dpls = data.dpls(:, i);
        wt.B = data.B;
        
        dpl_energies(i) = wt.net_dpl_U();
        B_energies(i) = wt.net_B_U();
    end
    
    figure;
    subplot(2, 1, 1);
    
    plot(data.time, dpl_energies);
    grid on;
    
    title("Zavisnost energije dipol-dipol interakcije od vremena");
    xlabel("Vreme");
    ylabel("Energija");
    
    subplot(2, 1, 2);
    
    plot(data.time, B_energies);
    grid on;
    
    title("Zavisnost energije interakcije sa magnetnim poljem od vremena");
    xlabel("Vreme");
    ylabel("Energija");
end

