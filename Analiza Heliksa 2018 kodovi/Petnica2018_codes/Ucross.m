function [out, f1] = Ucross( ri, rj, mi, mj, Lz )

% Modified Bessel function of the second kind ---- besselk(order,u);

ro = [(ri.x - rj.x) (ri.y - rj.y) 0];
z = ri.z - rj.z;

Mi_ro = [mi.x mi.y 0];
Mj_ro = [mj.x mj.y 0];
eta_z = (2.*pi/Lz)*z;
eta_ro = (2.*pi/Lz)*Moduo(ro);

S1 = 0;
S2 = 0;
S3 = 0;

kmax=min(round(30/eta_ro),1e5); %it is maximal index of the summation

f1=0;
if (kmax==1e5)
    f1=1;
    if (round(30/eta_ro)>1e7) 
        f1=2;
    end
end

for k=1:kmax
    Bk1=besselk(1,(k*eta_ro));
    S1 = S1 + k*cos(k*eta_z)*Bk1;
    S2 = S2 + k*k*sin(k*eta_z)*Bk1;
    S3 = S3 + k*k*cos(k*eta_z)*besselk(0,(k*eta_ro));
end

out1 = ((-8.*pi)/(Lz^2))*(2./((Moduo(ro))^3)*(Mi_ro*ro')*(Mj_ro*ro') - (1./(Moduo(ro)))*(Mi_ro*Mj_ro'))*S1;
out2 = ((-16.*(pi^2))/(Lz^3))*(1/(Moduo(ro)))*((Mi_ro*ro')*mj.z + (Mj_ro*ro')*mi.z)*S2;
out3 = ((-16.*(pi^2))/(Lz^3))*((1/((Moduo(ro))^2))*(Mi_ro*ro')*(Mj_ro*ro') - mi.z*mj.z)*S3;
out4 = (-2./Lz)*((2./((Moduo(ro))^4))*(Mi_ro*ro')*(Mj_ro*ro') - (1./((Moduo(ro))^2))*(Mi_ro*Mj_ro'));

out = out1 + out2 + out3 + out4;

end


