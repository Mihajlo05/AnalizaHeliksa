w.B = [0 0 B];

N = length(w.dpls);

nit = 100000;
last_nit = 1;
[data, lastIt] = w.simulate(0.01, nit);
ts = data.time;

figure

x1 = zeros(1, N);
y1 = zeros(1, N);
z1 = zeros(1, N);

for i = 1:N
    x1(i) = data.dpls(i, 1).pos(1);
    y1(i) = data.dpls(i, 1).pos(2);
    z1(i) = data.dpls(i, 1).pos(3);
end

scatter3(x1, y1, z1)

xlabel('x')
ylabel('y')
zlabel('z')

axis equal

figure

x2 = zeros(1, N);
y2 = zeros(1, N);
z2 = zeros(1, N);

mx2 = zeros(1, N);
my2 = zeros(1, N);
mz2 = zeros(1, N);

for i = 1:N
    x2(i) = data.dpls(i, lastIt).pos(1);
    y2(i) = data.dpls(i, lastIt).pos(2);
    z2(i) = data.dpls(i, lastIt).pos(3);
    
    mx2(i) = data.dpls(i, lastIt).ori(1);
    my2(i) = data.dpls(i, lastIt).ori(2);
    mz2(i) = data.dpls(i, lastIt).ori(3);
end

scatter3(x2, y2, z2)

xlabel('x')
ylabel('y')
zlabel('z')
axis equal

figure
quiver3(x2-0.5*mx2,y2-0.5*my2,z2-0.5*mz2,mx2,my2,mz2,0.5,'LineWidth',2)
axis equal

figure

Ds = zeros(1, lastIt);
Bs = zeros(1, lastIt);

for i = 1:lastIt
    wt = World;
    wt.dpls = data.dpls(:, i);
    
    BE = 0;
    
    for j = 1:N
        BE = BE + wt.B_dpl_U(wt.dpls(j), w.B);
    end
    
    Ds(i) = wt.net_dpl_U();
    Bs(i) = BE;
end

subplot(2, 1, 1)
plot(ts, Ds)
subplot(2, 1, 2)
plot(ts, Bs)

%for j = 1:100:length(ts)
%    wt = World;
%    wt.dpls = data.dpls(:, j);
%    
%    xs = zeros(1, N);
%    ys = zeros(1, N);
%    zs = zeros(1, N);
%    for i = 1:N
%        xs(i) = wt.dpls(i).pos(1);
%        ys(i) = wt.dpls(i).pos(2);
%        zs(i) = wt.dpls(i).pos(3);
%    end
%    
%    figure(j);
%    scatter3(xs, ys, zs);
%end

Thetas1 = zeros(1, lastIt);
Thetas2 = zeros(1, lastIt);
Rs1 = zeros(1, lastIt);
Rs2 = zeros(1, lastIt);

r1 = data.dpls(1, 1).pos;
r2 = data.dpls(14, 1).pos;

for i = 1:lastIt
    r3 = data.dpls(1, i).pos;
    r4 = data.dpls(14, i).pos;
    
    cosTheta1 = max(min(dot(r1,r3)/(norm(r1)*norm(r3)),1),-1);
    cosTheta2 = max(min(dot(r2,r4)/(norm(r2)*norm(r4)),1),-1);
    theta1 = real(acosd(cosTheta1));
    theta2 = real(acosd(cosTheta2));
    
    Thetas1(i) = theta1;
    Thetas2(i) = theta2;
    
    R1 = sqrt(sum(r3.^2, 'all'));
    R2 = sqrt(sum(r4.^2, 'all'));
    
    Rs1(i) = R1;
    Rs2(i) = R2;
end

figure
hold on
plot(ts, Thetas1)
plot(ts, Thetas2)
grid on

title("Zavisnost rotacije prstena od vremena")
xlabel("Vreme")
ylabel("Rotacija")

figure
hold on
plot(ts, Rs1)
plot(ts, Rs2)
grid on

figure(4)
subplot(2, 1, 1)
title("Zavisnost potencijalne energije dipol-dipol interakcije od vremena")
xlabel("Vreme")
ylabel("Energija")
subplot(2, 1, 2)
title("Zavisnost potencijalne energije interakcije sa magnetnim poljem od vremena")
xlabel("Vreme")
ylabel("Energija")

MZs = zeros(1, lastIt);

for i = 1:lastIt
    mz = 0;
    for j = 1:data.n_dpls
        mz = mz + data.dpls(j, i).ori(3);
    end
    MZs(i) = mz/data.n_dpls;
end

figure
plot(ts, MZs);
grid on;
title("Grafik zavisnost Z komponente dipolnog momenta od vremena")
xlabel("vreme")
ylabel("Z komponenta dipolnog momenta")

Hs = zeros(1, lastIt);

for i = 1:lastIt
    H = abs(data.dpls(1, i).pos(3) - data.dpls(data.n_dpls, i).pos(3));
    Hs(i) = H;
end

figure
plot(ts, Hs)
title("Grafik zavisnosti visine od vremena")
xlabel("Vreme")
ylabel("Visina")
grid on
