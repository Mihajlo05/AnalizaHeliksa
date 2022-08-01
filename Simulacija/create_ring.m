N = 11;
R = 1/(2*sin(pi/N));

w = World;
w.B = [0.1 0 0];

alpha = 0.514;

for i = 1:N
    x = R*cos(i*2*pi/N + alpha);
    y = R*sin(i*2*pi/N + alpha);

    mx = cos(i*2*pi/N + pi/2 + alpha);
    my = sin(i*2*pi/N + pi/2 + alpha);

    d = Dipole;
    d.pos = [x y 0];
    d.ori = [mx my 0];
    w.dpls = [w.dpls; d];
end


data = w.simulate(0.01, 10000);
ts = data.time;
Es = [];
Es2 = [];

for i = 1:length(ts)
    wt = World;
    wt.dpls = data.dpls(:, i);
    wt.B = w.B;

    Es = [Es, wt.net_dpl_U()/N];
    Es2 = [Es2, wt.net_B_U()/N];
end

figure
hold on
plot(ts, Es)
plot(ts, Es2)

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