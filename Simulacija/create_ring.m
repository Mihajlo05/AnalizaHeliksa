N = 5;
R = 1/(2*sin(pi/N));

w = World;

for i = 1:N
    x = R*cos(i*2*pi/N);
    y = R*sin(i*2*pi/N);
    
    mx = cos(i*2*pi/N + pi/2);
    my = sin(i*2*pi/N + pi/2);
    
    d = Dipole([x, y, 0], [mx, my, 0]);
    w.dpls = [w.dpls; d];
end


data = w.simulate(0.01, 1000);
ts = data.time;
Es = [];

for i = 1:length(ts)
    wt = World;
    wt.dpls = data.dpls(:, i);
    
    Es = [Es, wt.net_E()];
end

figure
plot(ts, Es)

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

figure

x2 = [];
y2 = [];
z2 = [];

for i = 1:N
    x2 = [x2, data.dpls(i, 1000).pos(1)];
    y2 = [y2, data.dpls(i, 1000).pos(2)];
    z2 = [z2, data.dpls(i, 1000).pos(3)];
end

scatter3(x2, y2, z2)
