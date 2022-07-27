w = World;
w.B = [0 0 0.1];

for i = 1:N
    w.dpls = [w.dpls; Dipole([r(i).x r(i).y r(i).z], [m(i).x m(i).y m(i).z])];
end

data = w.simulate(0.02, 500);
ts = data.time;

x1 = [];
y1 = [];
z1 = [];


for i = 1:N
    x1 = [x1, data.dpls(i, 1).pos(1)];
    y1 = [y1, data.dpls(i, 1).pos(2)];
    z1 = [z1, data.dpls(i, 1).pos(3)];
end

x2 = [];
y2 = [];
z2 = [];

for i = 1:N
    x2 = [x2, data.dpls(i, 500).pos(1)];
    y2 = [y2, data.dpls(i, 500).pos(2)];
    z2 = [z2, data.dpls(i, 500).pos(3)];
end

for i = 1:length(ts)
    wt = World;
    wt.dpls = data.dpls(:, i);
end

figure
scatter3(x1, y1, z1)
axis equal

figure
scatter3(x2, y2, z2)
axis equal

Bs = [];
Ds = [];

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

figure
hold on
plot(ts, Bs)
plot(ts, Ds)
