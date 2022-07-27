w.B = [0 0 0.1];

N = length(w.dpls);

nit = 1000;

data = w.simulate(0.01, nit);
ts = data.time;

figure

x1 = [];
y1 = [];
z1 = [];

for i = 1:N
    x1 = [x1, data.dpls(i, 1).pos(1)];
    y1 = [y1, data.dpls(i, 1).pos(2)];
    z1 = [z1, data.dpls(i, 1).pos(3)];
end

scatter3(x1, y1, z1)

xlabel('x')
ylabel('y')
zlabel('z')

axis equal

figure

x2 = [];
y2 = [];
z2 = [];

mx2 = [];
my2 = [];
mz2 = [];

for i = 1:N
    x2 = [x2, data.dpls(i, nit).pos(1)];
    y2 = [y2, data.dpls(i, nit).pos(2)];
    z2 = [z2, data.dpls(i, nit).pos(3)];
    
    mx2 = [mx2, data.dpls(i, nit).ori(1)];
    my2 = [my2, data.dpls(i, nit).ori(2)];
    mz2 = [mz2, data.dpls(i, nit).ori(3)];
end

scatter3(x2, y2, z2)

xlabel('x')
ylabel('y')
zlabel('z')
axis equal

figure

Ds = [];
Bs = [];

for i = 1:length(ts)
    wt = World;
    wt.dpls = data.dpls(:, i);
    
    BE = 0;
    
    for j = 1:N
        BE = BE + wt.B_dpl_U(wt.dpls(j), w.B);
    end
    Bs = [Bs, BE];
    Ds = [Ds, wt.net_dpl_U()];
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
    
    xs = [];
    ys = [];
    zs = [];
    for i = 1:N
        xs = [xs, wt.dpls(i).pos(1)];
        ys = [ys, wt.dpls(i).pos(2)];
        zs = [zs, wt.dpls(i).pos(3)];
    end
    
    figure(j);
    scatter3(xs, ys, zs);
end









