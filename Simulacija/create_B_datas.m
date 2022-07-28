B = 0;
dB = 0.05;

iters = 10;

datas(1:iters) = struct("n_dpls", 1,  "dpls", Dipole,  "time", 0, "dpl_r", 0.5,  "dpl_moment", [0 0 1], "dpl_mass", 1,  'e', 1);

for i = 1:iters
    disp("sim: " + string(i) + " " + string(ceil((i/iters)*100)) + "%");
    B = B + dB;
    Bs(i) = B;
    
    w.B = [0 0 B];
    [data, sim_iters] = w.simulate(0.03, 15000);
    datas(i) = data;
end