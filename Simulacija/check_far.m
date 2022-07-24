w = World;

w.dpls = [Dipole.default; Dipole.default];
w.dpls(2).pos = [0 0 3];

data = w.simulate(0.001, 1000);
ts = data.time;

z1 = [];
z2 = [];

Es = [];

for i = 1:length(ts)
    wt = World;
    wt.dpls = [data.dpls(1, i); data.dpls(2, i)];
    
    z1 = [z1, wt.dpls(1).pos(3)];
    z2 = [z2, wt.dpls(2).pos(3)];
    Es = [Es, wt.net_E()];
end

figure
subplot(2, 1, 1)
hold on
plot(ts, z1)
plot(ts, z2)

subplot(2, 1, 2)
plot(ts, Es)