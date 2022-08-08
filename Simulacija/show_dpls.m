function show_dpls(dpls)
    n = length(dpls);

    x = zeros(1, n);
    y = zeros(1, n);
    z = zeros(1, n);
        
    mx = zeros(1, n);
    my = zeros(1, n);
    mz = zeros(1, n);
        
    for i = 1:n
        x(i) = dpls(i).pos(1);
        y(i) = dpls(i).pos(2);
        z(i) = dpls(i).pos(3);
            
        mx(i) = dpls(i).ori(1);
        my(i) = dpls(i).ori(2);
        mz(i) = dpls(i).ori(3);
    end
    
    figure;
    axis equal;
    grid on;
    
    quiver3(x-0.5*mx,y-0.5*my,z-0.5*mz,mx,my,mz,0.5,'LineWidth',2);
        
    title("Struktura");
    xlabel('x');
    ylabel('y');
    zlabel('z');
end

