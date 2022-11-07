function dpls = create_AB_tube(Nd, Nr, alpha, pos)
%CREATE_AA_TUBE Summary of this function goes here
%   Nd is number of dipoles in ring
%   Nr in numver of ring
    dpls = [];
    
    for i = 1:Nr
        ring = create_ring(Nd, alpha + (i-1)*pi/Nd, pos);
        
        for j = 1:Nd
            ring(j).pos(3) = i-1;
        end
        
        dpls = [dpls; ring]; 
    end
end

