function plot_mz_time(data)
    n = length(data.time);
    MZs = zeros(1, length(data.time));
    
    for i = 1:n
        wt = World;
        wt.dpls = data.dpls(:, i);
        
        mz = 0;
        for j = 1:data.n_dpls
            mz = mz + wt.dpls(j).ori(3);
        end
        
        MZs(i) = mz / data.n_dpls;
    end
    
    figure;
    
    plot(data.time, MZs);
    grid on;
    
    title("Zavisnost Z komponente dipolnog momenta od vremena");
    xlabel("Vreme");
    ylabel("Z komponenta dipolnog momenta");
end