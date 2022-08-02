function dpls = create_ring(N, alpha, pos)
    dpls(1:N, 1) = Dipole;
    
    R = 1 / (2*sin(pi/N));
    
    for i = 1:N
        dpls(i).pos(1) = pos(1) + R*cos((i-1)*2*pi/N + alpha);
        dpls(i).pos(2) = pos(2) + R*sin((i-1)*2*pi/N + alpha);
        dpls(i).pos(3) = pos(3);
        
        dpls(i).ori(1) = cos((i-1)*2*pi/N + alpha + pi/2);
        dpls(i).ori(2) = sin((i-1)*2*pi/N + alpha + pi/2);
        dpls(i).ori(3) = 0;
    end
end

