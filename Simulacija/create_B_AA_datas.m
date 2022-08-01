B = 0;
dB = 0.05;

iters = 2;

BData = struct;
BData.DEs = zeros(1, iters);
BData.BEs = zeros(1, iters);
BData.MZs = zeros(1, iters);
BData.Hs = zeros(1, iters);
BData.Bs = zeros(1, iters);
%BData.Thetas = zeros(length(w.dpls)/7, iters);

for i = 1:iters
    disp("sim: " + string(i) + " " + string(ceil((i/iters)*100)) + "%");
    B = B + dB;
    BData.Bs(i) = B;
    
    w.B = [0 0 B];
    [data, lastIt] = w.simulate(0.03, 10);
    wt = World;
    wt.dpls = data.dpls(:, lastIt);
    
    BData.DEs(i) = w.net_dpl_U();
    BData.BEs(i) = w.net_B_U();
    
    mz = 0;
    for j = 1:data.n_dpls
        mz = mz + wt.dpls(j).ori(3);
    end
    
    mz = mz / data.n_dpls;
    
    BData.MZs(i) = mz;
    
    H = abs(wt.dpls(1).pos(3) - wt.dpls(data.n_dpls).pos(3));
    BData.Hs(i) = H;
end