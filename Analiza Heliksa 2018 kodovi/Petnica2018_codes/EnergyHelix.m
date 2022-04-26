function [E] = EnergyHelix(N, theta, R)

% This function calculates the energy of a helix
% Calculation of Lekner type method for summing the dipole-dipole interactions
% in computer simulations of one- and two-dimensionally periodic systems
% One cell is a helix
% List of the parameters: 
% N - number of dipoles in a helix, theta - angle, R - radius

% Let's set the coordinates of the dipoles 
   dz = sqrt(1 - ((cos(theta) - cos(2*theta))^2 + (sin(theta) - sin(2*theta))^2)*(R^2));
   for q=1:N
       r(q).x = R*cos(q*theta);
       r(q).y = R*sin(q*theta);
       r(q).z = (q - 1)*dz;
   end
   Lz = N*dz; % periodicity of the system along the z-axis
    
% Let's set the momentums of the dipoles
    zz=sqrt(1-(dz)^2);
    for i=1:N
    m(i).x = (-1)*zz*cos(i*theta + pi/2);
    m(i).y = (-1)*zz*sin(i*theta + pi/2);
    m(i).z = dz;
    end


% Calculation of the self energy
Eself = 0;
for i=1:N
    Eself = Eself + (1/(Lz^3))*(1 - 3*(m(i).z)*(m(i).z))*1.2020569031595942;
end

% Calculation of the cross energy
Ecross = 0;
f2=0;
for i=1:N
    for j=(i+1):N
        if (j~=i)
            [Uc, f1]=Ucross(r(i), r(j), m(i), m(j), Lz);
            f2=max(f1,f2);
            Ecross = Ecross + Uc;
        end
    end
end

E = (Eself + Ecross)/N;

end





