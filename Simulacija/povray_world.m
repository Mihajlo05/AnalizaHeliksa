function unionCode = povray_world(w)
    unionCode = "";
    
    for i = 1:length(w.dpls)
        povOri = w.dpls(i).ori;
        
        rotAxis = cross([1 0 0], w.dpls(i).ori);
        rotAxis = rotAxis/norm(rotAxis);
        rotAngle = atan2(norm(cross([1 0 0], povOri)), dot([1 0 0], povOri));
        
        translation = rotatepoint(quaternion(-rotAxis*rotAngle, 'rotvec'), w.dpls(i).pos);
        translation = w.dpls(i).pos;
        
        unionCode = unionCode + povray_dipole(translation, rotAxis, rotAngle) + newline + newline;
    end
end

