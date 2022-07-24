w = World;

for i = 1:N
    w.dpls = [w.dpls; Dipole([r(i).x r(i).y r(i).z], [0 0 0])];
    w.dpls(i).ori = [m(i).x m(i).y m(i).z];
end

data = w.simulate(0.01, 500);