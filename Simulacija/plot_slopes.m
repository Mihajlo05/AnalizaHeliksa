function plot_slopes(slopes)
    figure;
    grid on;
    hold on;
    
    s = ['ks--', 'kV--', 'ks-'];
    
    for i = 1:3
        plot(slopes(i).N, slopes(i).k, s(i));
    end
    
    xlabel("N");
    ylabel("k");
    legend("prsten", "AB Tuba", "AA Tuba");
end

