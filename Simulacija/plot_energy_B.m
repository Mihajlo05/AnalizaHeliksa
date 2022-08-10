function plot_energy_B(BData)
    N = length(BData.Bs);
    
    DEs = zeros(1, N);
    BEs = zeros(1, N);
    
    for i = 1:N
        wb = World;
        wb.dpls = BData.dpls(:, i);
        wb.B = [0 0 BData.Bs(i)];
        
        DEs(i) = wb.net_dpl_U() / BData.n_dpls;
        BEs(i) = wb.net_B_U() / (wb.B(3) * BData.n_dpls);
    end
    
    title("Zavisnost potencijalne energije od magnetne indukcije");
    xlabel("Magnetna indukcija");
    ylabel("Energija");
    
    plot(BData.Bs, DEs);
    plot(BData.Bs, BEs);
    
    legend('dipol-dipol interakcija', 'interakcija sa B poljem (normalizovana)', 'Location', 'best');
end

