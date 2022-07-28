B = 0;

DipEs = zeros(1, iters);
BEs = zeros(1, iters);
MZs = zeros(1, iters);
Theta1s = zeros(1, iters);
Theta2s = zeros(1, iters);

Bs = zeros(1, iters);
Hs = zeros(1, iters);

for i = 1:iters
    B = B + dB;
    Bs(i) = B;
    
    data = datas(i);
    sim_iters = length(data.time);
    
    wt = World;
    wt.B = [0 0 B];
    wt.dpls = data.dpls(:, sim_iters);
    
    Ed = wt.net_dpl_U();
    Eb = wt.net_B_U();
    
    mz = 0;
    for j = 1:data.n_dpls
        mz = mz + wt.dpls(j).ori(3);
    end
    
    mz = mz / data.n_dpls;
    
    DipEs(i) = Ed;
    BEs(i) = Eb;
    MZs(i) = mz;
    
    r1 = datas(1).dpls(1, 1).pos;
    r2 = datas(1).dpls(14, 1).pos;
    
    r3 = data.dpls(1, sim_iters).pos;
    r4 = data.dpls(14, sim_iters).pos;
    
    cosTheta1 = max(min(dot(r1, r3)/(norm(r1)*norm(r3)), 1), -1);
    cosTheta2 = max(min(dot(r2, r4)/(norm(r2)*norm(r4)), 1), -1);
    
    theta1 = real(acosd(cosTheta1));
    theta2 = real(acosd(cosTheta2));
    
    Theta1s(i) = theta1;
    Theta2s(i) = theta2;
    
    Hs(i) = abs(r4(3) - r3(3));
end

figure;
hold on;
grid on;

subplot(2, 1, 1);
plot(Bs, DipEs);

title("Zavisnost energije dipol-dipol interakcije od magnetne indukcije")
xlabel("Magnetna indukcija")
ylabel("Energija dipol-dipol interakcije")

subplot(2, 1, 2);
plot(Bs, BEs);

title("Zavisnost energije interakcije sa magnetnim poljem od magnetne indukcije")
xlabel("Magnetna indukcija")
ylabel("Energija interakcije sa magnetnim poljem")

figure;
plot(Bs, MZs);
title("Zavisnost z komponente dipolnog momenta od magnetne indukcije")
xlabel("Magnetna indukcija")
ylabel("Z komponenta dipolnog momenta")

figure(4)
hold on
grid on
plot(Bs, Theta1s)
plot(Bs, Theta2s)

title("Zavisnost rotacije prstena od magnetnog polja")
xlabel("Magnetna indukcija")
ylabel("Rotacija")

figure(5)
grid on
plot(Bs, Hs)

title("Zavisnost visine tuba od magnetnog polja")
xlabel("Magnetna indukcija")
ylabel("Visina")