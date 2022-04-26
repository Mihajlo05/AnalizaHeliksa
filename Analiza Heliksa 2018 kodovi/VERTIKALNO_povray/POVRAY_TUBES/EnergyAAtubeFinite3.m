function [r,m] = EnergyAAtubeFinite3(Nring,N)

R = (1/(2*sin(pi/Nring)));
dz  = 1; % distance between the two dipoles is equal to 1
    
Nr = (N/Nring);
    
for j=1:Nr
    for i=1:Nring
        in = (j-1)*Nring+i;
        r(in).x = R*cos(2*pi*i/Nring);
        r(in).y = R*sin(2*pi*i/Nring);
        r(in).z = (j-Nr/2)*dz;
    end
end
    
% Let's set the momentums of the dipoles
for j=1:Nr
    for i=1:Nring
        in = (j-1)*Nring+i;   
        mtx = cos(2*pi*i/Nring + pi/2);
        mty = sin(2*pi*i/Nring + pi/2);
        alfa = pi/4;
        mtx = mtx/sin(alfa);
        mty = mty/sin(alfa);
        fi = arr(mtx,mty);
        
        m(in).x = sin(alfa)*cos(fi);
        m(in).y = sin(alfa)*sin(fi);
        m(in).z = cos(alfa);
    end
end

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

figure(1)
plot3(xp,yp,zp, 'o');
axis equal;

figure(2)
quiver3(xp-0.5*mx,yp-0.5*my,zp-0.5*mz,mx,my,mz,1.65);
axis equal;

end
