N = 21;

R = 1/(2*sin(pi/(N/3)));

w = World;
w.B = [0 0 0];

nit = 3000;
alpha = 0;

beta = 0;

for i = 1:(N/3)
    x = R*cos(i*6*pi/N + alpha);
    y = R*sin(i*6*pi/N + alpha);

    mx = cos(i*6*pi/N + pi/2 + alpha);
    my = sin(i*6*pi/N + pi/2 + alpha);

    d = Dipole;
    d.pos = [x y 0];
    d.ori = [mx my 0];
    w.dpls = [w.dpls; d];
end

for i = 1:(N/3)
    x = R*cos(i*6*pi/N + alpha + beta);
    y = R*sin(i*6*pi/N + alpha + beta);

    mx = cos(i*6*pi/N + pi/2 + alpha + beta);
    my = sin(i*6*pi/N + pi/2 + alpha + beta);

    d = Dipole;
    d.pos = [x y 1];
    d.ori = [mx my 0];
    w.dpls = [w.dpls; d];
end

for i = 1:(N/3)
    x = R*cos(i*6*pi/N + alpha + 2*beta);
    y = R*sin(i*6*pi/N + alpha + 2*beta);

    mx = cos(i*6*pi/N + pi/2 + alpha + 2*beta);
    my = sin(i*6*pi/N + pi/2 + alpha + 2*beta);

    d = Dipole;
    d.pos = [x y 2];
    d.ori = [mx my 0];
    w.dpls = [w.dpls; d];
end


[data, lastIt] = w.simulate(0.01, nit);
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
    x2 = [x2, data.dpls(i, lastIt).pos(1)];
    y2 = [y2, data.dpls(i, lastIt).pos(2)];
    z2 = [z2, data.dpls(i, lastIt).pos(3)];

    mx2 = [mx2, data.dpls(i, lastIt).ori(1)];
    my2 = [my2, data.dpls(i, lastIt).ori(2)];
    mz2 = [mz2, data.dpls(i, lastIt).ori(3)];
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