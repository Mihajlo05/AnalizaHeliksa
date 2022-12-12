function unionCode = povray_dipole(translation, rotAxis, rotAngle)

    unionCode = "union{" + newline;
    unionCode = unionCode +	"cylinder { <-.4,0,0>,<.05,0,0>,.05 no_shadow }" + newline;
    unionCode = unionCode +	"cone { <.05, 0,0>,.1,<.4,0,0>,0 no_shadow}" + newline;
    unionCode = unionCode +	"sphere {<0, 0, 0>, .55 ";
    unionCode = unionCode + "pigment{ color Yellow transmit .3 } finish{ambient .2 phong .2} no_shadow}" + newline;
    unionCode = unionCode +	"pigment { rgb<.5, .5, .5> }" + newline;
    
    tx = translation(1);
    ty = translation(2);
    tz = translation(3);
    
    povT = "<" + string(tx) + ", " + string(tz) + ", " + string(ty) + ">";
    povRAxis = "<" + string(rotAxis(1)) + ", " + string(rotAxis(3)) + ", " + string(rotAxis(2)) + ">";
    
    
    unionCode = unionCode + "RotMatFromVectorAndAngle(" + povRAxis + ", ";
    unionCode = unionCode + string(rotAngle) + ")" + newline;
    unionCode = unionCode + "translate " + povT + newline + "}"; 
end

