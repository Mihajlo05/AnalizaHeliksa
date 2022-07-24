w = World;

w.dpls = [Dipole.default; Dipole.default; Dipole.default];

w.dpls(2).pos = [0 0 2];
w.dpls(3).pos = [0 0 4];

data = w.simulate(0.01, 1000);
ts = data.time;

Es = [];

z1 = [];
z2 = [];
z3 = [];

for i = 1:length(ts)
    w.dpls = [data.dpls(1, i); data.dpls(2, i); data.dpls(3, i)];
    Es = [Es, w.net_E()];
    
    z1 = [z1, w.dpls(1).pos(3)];
    z2 = [z2, w.dpls(2).pos(3)];
    z3 = [z3, w.dpls(3).pos(3)];
end

figure

subplot(2, 1, 1)
hold on
grid on
plot(ts, Es)

subplot(2, 1, 2)
hold on
grid on
plot(ts, z1)
plot(ts, z2)
plot(ts, z3)
