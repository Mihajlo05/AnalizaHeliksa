B = 0;
dB = 0.05;

iters = 10;

DipEs = [];
BEs = [];
MZs = [];
Theta1s = [];
Theta2s = [];

Bs = [];

datas = [];

for i = 1:iters
    B = B + dB;
    Bs = [Bs, B];
    
    w.B = [0 0 B];
    data = w.simulate(0.04, 1000);
    datas = [datas; data];
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
    
    DipEs = [DipEs, Ed];
    BEs = [BEs, Eb];
    MZs = [MZs, mz];
    
    r1 = datas(1).dpls(1, 1).pos;
    r2 = datas(1).dpls(14, 1).pos;
    
    r3 = data.dpls(1, i).pos;
    r4 = data.dpls(14, i).pos;
    
    cosTheta1 = max(min(dot(r1, r3)/(norm(r1)*norm(r3)), 1), -1);
    cosTheta2 = max(min(dot(r2, r4)/(norm(r2)*norm(r4)), 1), -1);
    
    theta1 = real(acosd(cosTheta1));
    theta2 = real(acosd(cosTheta2));
    
    Theta1s = [Theta1s, theta1];
    Theta2s = [Theta2s, theta2];
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
