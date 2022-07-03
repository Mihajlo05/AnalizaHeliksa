function strd = data_str(data)
    strd = "[n_dpls]" + newline;
    strd = strd + string(data.n_dpls) + newline;
    
    strd = strd + "[time]" + newline;
    
    for t = data.time
        strd = strd + string(t) + " ";
    end
    
    strd = strd + newline + "[dpls]" + newline;
    [x_size, y_size] = size(data.dpls);
    for i = 1:(x_size * y_size)
        for j = 1:3
            strd = strd + string(data.dpls(i).pos(j)) + " ";
        end
        for j = 1:3
            strd = strd + string(data.dpls(i).ori(j)) + " ";
        end
    end
    
    strd = strd + newline;
    strd = strd + "[dpl_r]" + newline + string(data.dpl_r) + newline;
    strd = strd + "[dpl_moment]" + newline + string(data.dpl_moment)  + newline;
    strd = strd + "[dpl_mass]" + newline + string(data.dpl_mass) + newline;
    strd = strd + "[e]" + newline + string(data.e) + newline;
end

