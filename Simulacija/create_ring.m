N = 11;
R = 1/(2*sin(pi/N));

w = World;
w.B = [9000 0 0];

nit = 950;
alpha = 0.514;

for i = 1:N
    x = R*cos(i*2*pi/N + alpha);
    y = R*sin(i*2*pi/N + alpha);
    
    mx = cos(i*2*pi/N + pi/2 + alpha);
    my = sin(i*2*pi/N + pi/2 + alpha);
    
    d = Dipole([x, y, 0], [mx, my, 0]);
    w.dpls = [w.dpls; d];
end


data = w.simulate(0.0005, nit);
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

for i = 1:N
    x2 = [x2, data.dpls(i, nit).pos(1)];
    y2 = [y2, data.dpls(i, nit).pos(2)];
    z2 = [z2, data.dpls(i, nit).pos(3)];
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
