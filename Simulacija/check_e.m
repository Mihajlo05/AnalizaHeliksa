w = World;

d1 = Dipole.default;
d2 = d1;
d2.pos = [0 0 2.05];

w.dpls = [d1; d2];

data = w.simulate(0.005, 1000);
ts = data.time;

KEs1 = [];
KEs2 = [];
PEs = [];
PLJs = [];
Es = [];

for i = 1:length(ts)
    d1 = data.dpls(1, i);
    d2 = data.dpls(2, i);
    
    KE1 = w.dpl_KE(d1);
    KE2 = w.dpl_KE(d2);
    PE = w.dpl_dpl_U(d1, d2);
    PLJ = w.lj_U(d1, d2);
    
    KEs1 = [KEs1, KE1];
    KEs2 = [KEs2, KE2];
    PEs = [PEs, PE];
    PLJs = [PLJs, PLJ];
    Es = [Es, KE1 + KE2 + PE + PLJ];
end

figure
hold on

plot(ts, KEs1)
plot(ts, KEs2)
plot(ts, PEs)
plot(ts, PLJs)
plot(ts, Es)

grid on

legend('KE1', 'KE2', 'PE', 'PLJ', 'E')