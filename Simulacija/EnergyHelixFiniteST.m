function [r,m,R] = EnergyHelixFiniteST(N,theta,R)

% This function calculates the energy of a finite helix

% List of the parameters: 
% N - number of dipoles in a helix, theta - angle, R - radius

% Let's set the coordinates of the dipoles 
dz = sqrt(1 - ((cos(theta) - cos(2*theta))^2 + (sin(theta) - sin(2*theta))^2)*(R^2));
   for q=1:N
       r(q).x = R*cos(q*theta);
       r(q).y = R*sin(q*theta);
       r(q).z = (q - 1)*dz;
   end
     
% Let's set the momentums of the dipoles
    zz=sqrt(1-(dz)^2);
    for i=1:N
    m(i).x = zz*cos(i*theta + pi/2);
    m(i).y = zz*sin(i*theta + pi/2);
    m(i).z = dz;
    end

    
% % Calculation of the cross energy (per particle)
% Ecross = 0;
% for i=1:N
%     for j=i+1:N
%             Uc = dipole(r(i), r(j), m(i), m(j));
%             Ecross = Ecross + Uc;
%     end
% end
% E = Ecross/N;

% % Calculation of the cross energy (central particle)
% Ecross=0;
% i=floor(N/2);
%     for j=1:N
%         if (j~=i) 
%             Uc = 0.5*dipole(r(i), r(j), m(i), m(j));
%             Ecross = Ecross + Uc;
%         end
%     end
% EO=Ecross;


%--------------------------------------------------------------------------
xp=zeros(N,1);
yp=zeros(N,1);
zp=zeros(N,1);
mx=zeros(N,1);
my=zeros(N,1);
mz=zeros(N,1);

for i=1:N
xp(i)=r(i).x;
yp(i)=r(i).y;
zp(i)=r(i).z;

mx(i)=m(i).x;
my(i)=m(i).y;
mz(i)=m(i).z;
end

figure(1);
plot3(xp,yp,zp, 'o');
axis equal;

figure(2);
quiver3(xp-0.5*mx,yp-0.5*my,zp-0.5*mz,mx,my,mz,0.5,'LineWidth',2);
axis equal;
%--------------------------------------------------------------------------

end





