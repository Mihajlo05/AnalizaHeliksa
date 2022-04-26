% This script generates the Povray code using the data about a given
% tube or helix configuration

% Preparations for the next code, we make arrays xx,yy,zz from the
% structure r.x, r.y, r.z

clear xx; clear yy; clear zz;

L = 3;

for i=L:N
    xx(i) = r(i).x;
    yy(i) = r(i).y;
    zz(i) = r(i).z;
end
x = (min(xx) + max(xx))/2;
y = (min(yy) + max(yy))/2;
z = (min(zz) + max(zz))/2;
 
s1 = '';
s2 = '';

string1 = '#include "colors.inc"';
string2 = 'background { color White }';
string3 = 'light_source{ <0,0,0> color rgb<1.0,1.0,1.0> adaptive 0 jitter translate <0,10,5> }';
string4 = 'light_source { < 7,20,30> color rgb<0.5,0.5,0.5> shadowless}';
string5 = 'light_source { < 12,20,0> color rgb<0.5,0.5,0.5> shadowless}';
string6 = 'light_source { <-12,20,0> color rgb<0.5,0.5,0.5> shadowless}';
string7 = 'light_source { <-7,20,30> color rgb<0.5,0.5,0.5> shadowless}';
string8 = '#declare color2 = texture { pigment { color rgbt <0.246, 0.203, 0.461, .5> } finish { specular 0.5 roughness 0.03} }';
string9 = '#declare color1 = texture { pigment { color rgbt <0.246, 0.203, 0.461, .1> } finish { specular 0.5 roughness 0.03} }';
string10 = strcat('camera { orthographic location <',num2str(0),',',num2str(10*R),',',num2str((min(zz)+max(zz))),'> look_at  <',num2str(x),',',num2str(y),',',num2str(z),'> sky <0,0,1>}');


t = [string1 char(10) string2 char(10) string3 char(10) string4 char(10) string5 char(10) string6 char(10) string7 char(10) string8 char(10) string9 char(10) string10 char(10)];
  
for i=L:N
    str1 = strcat('#declare z',num2str(i),' = <',num2str(r(i).x),',',num2str(r(i).y),',',num2str(r(i).z),'>;');
    str2 = strcat('#declare dip',num2str(i),' = <',num2str(m(i).x),',',num2str(m(i).y),',',num2str(m(i).z),'>;');
    
    temp1 = [char(10) str1 char(10) str2 char(10)];
    s1 = strcat(s1,temp1);

    transp = 0;
    
    if (r(i).z/max(zz)<2)
    string3 = strcat('sphere { z',num2str(i),' 0.5 texture { pigment { color rgbt <0.246, 0.203, 0.461,',num2str(transp),'> } finish { specular 0.2 roughness 0.03} } no_shadow }');
    else
    string3 ='';
    end
%     string4 = strcat('cone { z',num2str(i),'+0.3*dip',num2str(i),' .12 z',num2str(i),'+0.5*dip',num2str(i),', .01 texture { pigment {color rgb<0.1,0.1,0.1>} finish {phong 0.2} } no_shadow }');
%     string5 = strcat('cylinder { z',num2str(i),'+0.45*dip',num2str(i),' ,z',num2str(i),'-0.49*dip',num2str(i),' 0.04 texture { pigment {color rgb<0.1,0.1,0.1>} finish {phong 0.2} } no_shadow }');
    string4 = '';
    string5 = '';
    temp2 = [char(10) string3 char(10) string4 char(10) string5 char(10)];
    s2 = strcat(s2,temp2);
end

stringD = strcat('cylinder { <0,0,',num2str(min(zz) - 1),'>,','<0,0,',num2str(max(zz) + 1),'>,',num2str(R-0.5));
stringF = 'open texture { pigment {color Gray} finish {phong 1} } }';


string = [t char(10) s1 char(10) 'union{' char(10) s2 char(10) stringD char(10) stringF char(10) '}'];
save('output.mat','string');