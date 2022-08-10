function plot_height_B(BData)
    N = length(BData.Bs);
    
    Hs = zeros(1, N);
    
    for i = 1:N
        d1 = BData.dpls(1, i);
        d2 = BData.dpls(BData.n_dpls, i);
        
        Hs(i) = abs(d2.pos(3) - d1.pos(3));
    end
    title("Zavisnost visine od magnetne indukcije");
    
    xlabel("Magnetna indukcija");
    ylabel("Visina");
    
    plot(BData.Bs, Hs);
end

