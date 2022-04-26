function [r,m,R,N] = EnergyABtubeFinite1(Nring,N)

% ST AB tube FINITE

    R = (1/(2*sin(pi/Nring))); % radius of the rings
    
    % One dipole in the lower ring
    r1x = R*cos(pi*3/Nring);
    r1y = R*sin(pi*3/Nring);
    
    % Corresponding dipole in the upper ring
    r2x = R*cos(pi*4/Nring);
    r2y = R*sin(pi*4/Nring);
    
    % distance between them is equal to 1 => dz
    dz  = sqrt(1-(r1x-r2x)^2-(r1y-r2y)^2);
    
    Nr = floor(N/(2*Nring)); % number of the rings
    
    for j=1:Nr
       for i=1:(2*Nring)
         ind = 2*(j-1)*Nring + i;
         r(ind).x = R*cos(pi*i/Nring);
         r(ind).y = R*sin(pi*i/Nring);
         r(ind).z = 2*(j - 1)*dz+dz*mod(i,2);
       end
    end
    
% Let's set the momentums of the dipoles
    for j=1:Nr
      for i=1:(2*Nring)
        ind = 2*(j-1)*Nring + i;
        m(ind).x = cos(pi*i/Nring + pi/2);
        m(ind).y = sin(pi*i/Nring + pi/2);
        m(ind).z = 0;
      end
    end
        
    
% % Calculation of the cross energy - (central dipole)
% Ecross = 0;
% i=floor(N/2);
% for j=1:N
%         if (j~=i)
%             Uc =0.5*dipole(r(i), r(j), m(i), m(j));
%             Ecross = Ecross + Uc;
%         end
% end
% 
% EcrossOne = Ecross;
%     
%        
% % Calculation of the cross energy - (per one dipole)
% Ecross = 0;
% 
% for i=1:N
%     for j=i+1:N
%         if (j~=i)
%             [Uc]=dipole(r(i), r(j), m(i), m(j));
%             Ecross = Ecross + Uc;
%         end
%     end
% end
% 
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

figure(2)
quiver3(xp-0.5*mx,yp-0.5*my,zp-0.5*mz,mx,my,mz,1.15,'LineWidth',2);
axis equal;

end