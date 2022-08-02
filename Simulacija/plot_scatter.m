function plot_scatter(data)
    N = length(data.time);

    x1 = zeros(1, data.n_dpls);
    y1 = zeros(1, data.n_dpls);
    z1 = zeros(1, data.n_dpls);
    
    x2 = zeros(1, data.n_dpls);
    y2 = zeros(1, data.n_dpls);
    z2 = zeros(1, data.n_dpls);
    
    for i = 1:data.n_dpls
        x1(i) = data.dpls(i, 1).pos(1);
        y1(i) = data.dpls(i, 1).pos(2);
        z1(i) = data.dpls(i, 1).pos(3);
        
        x2(i) = data.dpls(i, N).pos(1);
        y2(i) = data.dpls(i, N).pos(2);
        z2(i) = data.dpls(i, N).pos(3);
    end
    
    figure;
    scatter3(x1, y1, z1);
    
    title("Prostor");
    xlabel('x');
    ylabel('y');
    zlabel('z');
    
    figure;
    scatter3(x2, y2, z2);
    
    title("Prostor");
    xlabel('x');
    ylabel('y');
    zlabel('z');
end

