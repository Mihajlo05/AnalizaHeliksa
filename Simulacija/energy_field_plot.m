B = 0;
dB = 0.05;

iters = 6;

DipEs = [];
BEs = [];
MZs = [];

Bs = [];

datas = [];

for i = 1:iters
    B = B + dB;
    Bs = [Bs, B];
    
    w.B = [0 0 B];
    %data = w.simulate(0.04, 1000);
    %datas = [datas; data];
    data = datas(i);
    
    wt = World;
    wt.B = w.B;
    wt.dpls = data.dpls(:, 1001);
    
    Ed = wt.net_dpl_U();
    Eb = wt.net_B_U();
    
    mz = 0;
    for j = 1:length(wt.dpls)
        mz = mz + wt.dpls(j).ori(3);
    end
    
    mz = mz / length(data.dpls);
    
    DipEs = [DipEs, Ed];
    BEs = [BEs, Eb];
    MZs = [MZs, mz];
end

figure;
hold on;
grid on;

subplot(2, 1, 1);
plot(Bs, DipEs);

subplot(2, 1, 2);
plot(Bs, BEs);

figure;
plot(Bs, MZs);

