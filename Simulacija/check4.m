w = World;

d = Dipole.default;

w.dpls = [d;d;d;d];

w.dpls(1).ori = [1.4142, 0, 1.4142];

w.dpls(2).pos = [0 0 1];
w.dpls(2).ori = [-1.4142, 0, 1.4142];

w.dpls(3).pos = [-1 0 1];
w.dpls(3).ori = [-1.4142, 0, -1.4142];

w.dpls(4).pos = [-1 0 0];
w.dpls(4).ori = [1.4142, 0, -1.4142];

data = w.simulate(0.01, 1000);

ts = data.time;

x1 = [];
x2 = [];
x3 = [];
x4 = [];

y1 = [];
y2 = [];
y3 = [];
y4 = [];

z1 = [];
z2 = [];
z3 = [];
z4 = [];

Es = [];

for i = 1:length(ts)
    z1 = [z1, data.dpls(1, i).pos(3)];
    z2 = [z2, data.dpls(2, i).pos(3)];
    z3 = [z3, data.dpls(3, i).pos(3)];
    z4 = [z4, data.dpls(4, i).pos(3)];
    
    x1 = [x1, data.dpls(1, i).pos(1)];
    x2 = [x2, data.dpls(2, i).pos(1)];
    x3 = [x3, data.dpls(3, i).pos(1)];
    x4 = [x4, data.dpls(4, i).pos(1)];
    
    y1 = [y1, data.dpls(1, i).pos(2)];
    y2 = [y2, data.dpls(2, i).pos(2)];
    y3 = [y3, data.dpls(3, i).pos(2)];
    y4 = [y4, data.dpls(4, i).pos(2)];
    
    w.dpls = [data.dpls(1, i); data.dpls(2, i); data.dpls(3, i); data.dpls(4, i)];
    
    Es = [Es, w.net_E()];
    
    LJ = 0;
    for j = 1:length(w.dpls)
        for k = (j+1):length(w.dpls)
            LJ = LJ + w.lj_U(w.dpls(j), w.dpls(k));
        end
    end
    
    LJs = [LJs, LJ];
end

figure(1)
hold on
grid on

plot(ts, z1)
plot(ts, z2)
plot(ts, z3)
plot(ts, z4)

figure(2)
hold on
grid on
plot(ts, Es)
plot(ts, LJs)

figure(3)
hold on
grid on
scatter3([x1(1), x2(1), x3(1), x4(1)], [y1(1), y2(i), y3(3), y4(4)], [z1(1), z2(1), z3(1), z4(1)])

