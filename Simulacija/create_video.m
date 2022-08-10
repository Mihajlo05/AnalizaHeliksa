function create_video(data)
    N = length(data.time);
    
    for i = 1:1000:N
        figure(i);
        axis equal;
        grid on;
        
        x = zeros(1, data.n_dpls);
        y = zeros(1, data.n_dpls);
        z = zeros(1, data.n_dpls);
        
        mx = zeros(1, data.n_dpls);
        my = zeros(1, data.n_dpls);
        mz = zeros(1, data.n_dpls);
        
        t = data.time(i);
        
        for j = 1:data.n_dpls
            x(j) = data.dpls(j, i).pos(1);
            y(j) = data.dpls(j, i).pos(2);
            z(j) = data.dpls(j, i).pos(3);
            
            mx(j) = data.dpls(j, i).ori(1);
            my(j) = data.dpls(j, i).ori(2);
            mz(j) = data.dpls(j, i).ori(3);
        end
        
        quiver3(x-0.5*mx,y-0.5*my,z-0.5*mz,mx,my,mz,0.5,'LineWidth',2);
        
        title("t = " + string(t));
        xlabel('x');
        ylabel('y');
        zlabel('z');
    end
end

