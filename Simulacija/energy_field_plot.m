B = 0;
dB = 0.05;

iters = 10;

DipEs = zeros(1, iters);
BEs = zeros(1, iters);
MZs = zeros(1, iters);
Theta1s = zeros(1, iters);
Theta2s = zeros(1, iters);

Bs = zeros(1, iters);

datas(1:iters) = struct("n_dpls", 1,  "dpls", Dipole,  "time", 0, "dpl_r", 0.5,  "dpl_moment", [0 0 1], "dpl_mass", 1,  'e', 1);

for i = 1:iters
    B = B + dB;
    Bs(i) = B;
    
    w.B = [0 0 B];
    data = w.simulate(0.01, 1000);
    datas(i) = data;
    %data = datas(i);
    
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
    
    DipEs(i) = Ed;
    BEs(i) = Eb;
    MZs(i) = mz;
    
    r1 = datas(1).dpls(1, 1).pos;
    r2 = datas(1).dpls(14, 1).pos;
    
    r3 = data.dpls(1, 1000).pos;
    r4 = data.dpls(14, 1000).pos;
    
    cosTheta1 = max(min(dot(r1, r3)/(norm(r1)*norm(r3)), 1), -1);
    cosTheta2 = max(min(dot(r2, r4)/(norm(r2)*norm(r4)), 1), -1);
    
    theta1 = real(acosd(cosTheta1));
    theta2 = real(acosd(cosTheta2));
    
    Theta1s(i) = theta1;
    Theta2s(i) = theta2;
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

figure(4)
hold on
grid on
plot(Bs, Theta1s)
plot(Bs, Theta2s)
