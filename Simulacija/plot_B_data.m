figure(1);
hold on;
grid on;

subplot(2, 1, 1);
plot(BData.Bs, BData.DEs);

title("Zavisnost energije dipol-dipol interakcije od magnetne indukcije")
xlabel("Magnetna indukcija")
ylabel("Energija dipol-dipol interakcije")

subplot(2, 1, 2);
plot(BData.Bs, BData.BEs);

title("Zavisnost energije interakcije sa magnetnim poljem od magnetne indukcije")
xlabel("Magnetna indukcija")
ylabel("Energija interakcije sa magnetnim poljem")

figure(2);
plot(BData.Bs, BData.MZs);
title("Zavisnost z komponente dipolnog momenta od magnetne indukcije")
xlabel("Magnetna indukcija")
ylabel("Z komponenta dipolnog momenta")

%figure(3)
%hold on
%grid on
%plot(Bs, Theta1s)
%plot(Bs, Theta2s)

%title("Zavisnost rotacije prstena od magnetnog polja")
%xlabel("Magnetna indukcija")
%ylabel("Rotacija")

figure(4)
grid on
plot(BData.Bs, BData.Hs)

title("Zavisnost visine tuba od magnetnog polja")
xlabel("Magnetna indukcija")
ylabel("Visina")