function plot_energyb_B(BData, option)
    N = length(BData.Bs);
    
    BEs = zeros(1, N);
    
    for i = 1:N
        wb = World;
        wb.dpls = BData.dpls(:, i);
        wb.B = [0 0 BData.Bs(i)];
        
        BEs(i) = wb.net_B_U() / (BData.n_dpls);
    end
    
    title("Zavisnost potencijalne energije interakcije sa magnetnim poljem od magnetne indukcije");
    xlabel("Magnetna indukcija");
    ylabel("Energija");
    
    plot(BData.Bs, BEs, option);
end

