function dpls = create_AA_tube(Nd, Nr, alpha, pos)
%CREATE_AA_TUBE Summary of this function goes here
%   Nd is number of dipoles in ring
%   Nr in numver of ring
    dpls = [];
    
    base_ring = create_ring(Nd, alpha, pos);
    
    for i = 1:Nr
        ring = base_ring;
        
        for j = 1:Nd
            ring(j).pos(3) = i-1;
        end
        
        dpls = [dpls; ring]; 
    end
end

