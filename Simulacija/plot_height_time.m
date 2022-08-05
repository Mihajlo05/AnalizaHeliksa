function plot_height_time(data)
    Hs = zeros(1, length(data.time));
    
    for i = 1:length(data.time)
        d1 = data.dpls(1, i);
        d2 = data.dpls(data.n_dpls, i);
        
        Hs(i) = abs(d2.pos(3) - d1.pos(3));
    end
    
    figure;
    grid on;
    
    plot(data.time, Hs);
    
    title("Zavisnost visine od vremena");
    xlabel("Vreme");
    ylabel("Visina");
end

