function plot_mz_B(BData, option)
    N = length(BData.Bs);
    MZs = zeros(1, N);
    
    for i = 1:N
        wt = World;
        wt.dpls = BData.dpls(:, i);
        
        mz = 0;
        for j = 1:BData.n_dpls
            mz = mz + wt.dpls(j).ori(3);
        end
        
        MZs(i) = mz / BData.n_dpls;
    end
    plot(BData.Bs, MZs, option);
    grid on;
    
    title("Zavisnost Z komponente dipolnog momenta od magnetne indukcije");
    xlabel("Magnetna indukcija");
    ylabel("Z komponenta dipolnog momenta");
end
