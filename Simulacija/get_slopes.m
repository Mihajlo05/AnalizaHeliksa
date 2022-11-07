r = "BDatar";
a = "BData2A";
b = "BData2B";

names = [r, b, a];
slopes = [struct('N', [], 'k', []), struct('N', [], 'k', []), struct('N', [], 'k', [])];

for i = 1:3
    if i ~= 3
        for j = 4:10
            load(names(i) + string(j) + '.mat');
            MZs = plot_mz_B(bd, 'ks--');
            k = (MZs(2) - MZs(1))/(bd.Bs(2) - bd.Bs(1));
            slopes(i).N = [slopes(i).N, j];
            slopes(i).k = [slopes(i).k, k];
        end
    else
        for j = 4:7
            load(names(i) + string(j) + '.mat');
            MZs = plot_mz_B(bd, 'ks--');
            k = (MZs(2) - MZs(1))/(bd.Bs(2) - bd.Bs(1));
            slopes(i).N = [slopes(i).N, j];
            slopes(i).k = [slopes(i).k, k];
        end
    end
end