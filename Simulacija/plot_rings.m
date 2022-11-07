function plot_rings()
    name = 'BData2A';
    
    figure(1);
    hold on;
    figure(2);
    hold on;
    figure(3);
    hold on;
    
    for i = 4:8
        load(name + string(i) + '.mat');
        
        figure(1);
        plot_mz_B(bd, '');
        
        figure(2);
        plot_energyd_B(bd, '');
        
        figure(3);
        plot_energyb_B(bd, '');
    end
    
    for i = 1:3
        figure(i);
        legend('4', '5', '6', '7', '8', '9', '10');
    end
end

