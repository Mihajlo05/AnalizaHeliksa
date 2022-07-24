x = [];
y = [];
z = [];

mx = [];
my = [];
mz = [];

it = 500;

for i = 1:N
    x = [x, data.dpls(i, it).pos(1)];
    y = [y, data.dpls(i, it).pos(2)];
    z = [z, data.dpls(i, it).pos(3)];
    
    mx = [mx, data.dpls(i, it).ori(1)];
    my = [my, data.dpls(i, it).ori(2)];
    mz = [mz, data.dpls(i, it).ori(3)];
end

Es = [];
ts = data.time;

for i = 1:length(ts)
    w.dpls = data.dpls(:, i);
    Es = [Es, w.net_E()];
end

figure
%quiver3(x-0.5*mx,y-0.5*my,z-0.5*mz,mx,my,mz,0.5,'LineWidth',2);
scatter3(x, y, z)
axis equal

figure
hold on
grid on
plot(ts, Es)

