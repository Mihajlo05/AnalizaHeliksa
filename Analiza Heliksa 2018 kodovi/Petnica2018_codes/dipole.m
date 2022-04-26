function [ out ] = dipole( ri, rj, mi, mj)

ro = [(ri.x - rj.x) (ri.y - rj.y) (ri.z-rj.z)];

Mi_ro = [mi.x mi.y mi.z];
Mj_ro = [mj.x mj.y mj.z];

Mro=Moduo(ro);

out =  (Mi_ro*Mj_ro')/Mro^3-3.*(Mi_ro*ro')*(Mj_ro*ro')/Mro^5;

end


