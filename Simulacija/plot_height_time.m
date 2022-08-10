function plot_height_time(data)
    Hs = zeros(1, (length(data.time)-1)/100);
    
    for i = 1:(length(data.time)-1)/100
        d1 = data.dpls(1, i*100);
        d2 = data.dpls(data.n_dpls, i*100);
        
        Hs(i) = abs(d2.pos(3) - d1.pos(3));
    end
    
    figure;
    grid on;
    
    plot(1:100:length(data.time)-1, Hs);
    
    title("Zavisnost visine od vremena");
    xlabel("Vreme");
    ylabel("Visina");
end

