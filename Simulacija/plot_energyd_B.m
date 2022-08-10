function plot_energyd_B(BData, option)
    N = length(BData.Bs);
    
    DEs = zeros(1, N);
    
    for i = 1:N
        wb = World;
        wb.dpls = BData.dpls(:, i);
        wb.B = [0 0 BData.Bs(i)];
        
        DEs(i) = wb.net_dpl_U() / BData.n_dpls;
    end
    
    title("Zavisnost dipol-dipol potencijalne energije od magnetne indukcije");
    xlabel("Magnetna indukcija");
    ylabel("Energija");
    
    plot(BData.Bs, DEs, option);
end

