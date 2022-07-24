w = World;

d = Dipole.default;
d.ori = [0 0 1];

w.dpls = [d; d];

w.dpls(2).pos = [2 0 0];
w.dpls(2).vel = [0 0 0];

data = w.simulate(0.01, 1000);
ts = data.time;

x1 = [];
x2 = [];
Es = [];
KEs = [];
PEs = [];

for i = 1:length(ts)
    wt = World;
    wt.dpls = [data.dpls(1, i); data.dpls(2, i)];
    x1 = [x1, data.dpls(1, i).pos(1)];
    x2 = [x2, data.dpls(2, i).pos(1)];
    Es = [Es, wt.net_E()];
    KEs = [KEs, wt.net_KE()];
    PEs = [PEs, wt.net_dpl_U()];
end

figure
hold on
grid on

plot(ts, x1)
plot(ts, x2)

figure
hold on
plot(ts, Es)
plot(ts, KEs)
plot(ts, PEs)
legend('E', 'KE', 'PE')