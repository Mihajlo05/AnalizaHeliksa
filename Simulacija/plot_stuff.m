w.B = [0 0 B];

N = length(w.dpls);

nit = 4000;

data = w.simulate(0.04, nit);
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
    x2(i) = data.dpls(i, nit).pos(1);
    y2(i) = data.dpls(i, nit).pos(2);
    z2(i) = data.dpls(i, nit).pos(3);
    
    mx2(i) = data.dpls(i, nit).ori(1);
    my2(i) = data.dpls(i, nit).ori(2);
    mz2(i) = data.dpls(i, nit).ori(3);
end

scatter3(x2, y2, z2)

xlabel('x')
ylabel('y')
zlabel('z')
axis equal

figure

Ds = zeros(1, length(ts));
Bs = zeros(1, length(ts));

for i = 1:length(ts)
    wt = World;
    wt.dpls = data.dpls(:, i);
    
    BE = 0;
    
    for j = 1:N
        BE = BE + wt.B_dpl_U(wt.dpls(j), w.B);
    end
    Bs(i) = BE;
    Ds(i) = wt.net_dpl_U();
end

subplot(2, 1, 1)
plot(ts, Ds)
subplot(2, 1, 2)
plot(ts, Bs)

figure;
quiver3(x2-0.5*mx2,y2-0.5*my2,z2-0.5*mz2,mx2,my2,mz2,0.5,'LineWidth',2);
axis equal;

for j = 1:100:length(ts)
    wt = World;
    wt.dpls = data.dpls(:, j);
    
    xs = zeros(1, N);
    ys = zeros(1, N);
    zs = zeros(1, N);
    for i = 1:N
        xs(i) = wt.dpls(i).pos(1);
        ys(i) = wt.dpls(i).pos(2);
        zs(i) = wt.dpls(i).pos(3);
    end
    
    figure(j);
    scatter3(xs, ys, zs);
end

Thetas1 = zeros(1, length(ts));
Thetas2 = zeros(1, length(ts));
Rs1 = zeros(1, length(ts));
Rs2 = zeros(1, length(ts));

r1 = data.dpls(1, 1).pos;
r2 = data.dpls(14, 1).pos;

for i = 1:length(ts)
    r3 = data.dpls(1, i).pos;
    r4 = data.dpls(14, i).pos;
    
    cosTheta1 = max(min(dot(r1,r3)/(norm(r1)*norm(r3)),1),-1);
    cosTheta2 = max(min(dot(r2,r4)/(norm(r2)*norm(r4)),1),-1);
    theta1 = real(acosd(cosTheta1));
    theta2 = real(acosd(cosTheta2));
    
    Thetas1(i) = theta1;
    Thetas2(i) = theta2;
    
    R1 = sqrt(sum(r1.^2, 'all'));
    R2 = sqrt(sum(r2.^2, 'all'));
    
    Rs1(i) = R1;
    Rs2(i) = R2;
end

figure
hold on
plot(ts, Thetas1)
plot(ts, Thetas2)
grid on

figure
hold on
plot(ts, Rs1)
plot(ts, Rs2)
grid on
