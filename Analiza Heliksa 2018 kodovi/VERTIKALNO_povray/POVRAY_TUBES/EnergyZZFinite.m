function [r,m,R] = EnergyZZFinite(Nring,N)


R = (sqrt(3)/(4*sin(pi/Nring)));
dz  = 1; % distance between the two dipoles is equal to 1
    
Nr = floor(N/Nring); % number of cells
    
    for j=1:Nr
        ind = Nring*(j-1);
        for i=1:Nring
            r(ind+i).x = R*cos(2*pi*i/Nring);
            r(ind+i).y = R*sin(2*pi*i/Nring);
            r(ind+i).z = (j-1)*dz+0.5*mod(i,2);
        
            m(ind+i).x = 0;
            m(ind+i).y = 0;
            m(ind+i).z = 1;
        end
    end
    
% % Calculation of the cross energy - (per middle dipole)
% Ecross = 0;
% i=floor(N/2);
% for j=1:N
%         if (j~=i)
%             Uc =0.5*dipole(r(i), r(j), m(i), m(j));
%             Ecross = Ecross + Uc;
%         end
% end
% EcrossOne = Ecross;
% 
% % Calculation of the cross energy - (mean value)
% Ecross = 0;
% for i=1:N
%     for j=i+1:N
%         if (j~=i)
%             Uc =dipole(r(i), r(j), m(i), m(j));
%             Ecross = Ecross + Uc;
%         end
%     end
% end
% Ecross = Ecross/N;

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

figure(1)
plot3(xp,yp,zp, 'o');
axis equal;

figure(2);
quiver3(xp-0.5*mx,yp-0.5*my,zp-0.5*mz,mx,my,mz,0.15);
axis equal;

end




