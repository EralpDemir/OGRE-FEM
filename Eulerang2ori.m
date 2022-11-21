function [g] = Eulerang2ori(phi1, PHI, phi2)

% Euler angles in radians



% INPUT Crystal orientations   

g(1,1)=cos(phi1)*cos(phi2)-sin(phi1)*sin(phi2)*cos(PHI);
g(2,1)=-cos(phi1)*sin(phi2)-sin(phi1)*cos(phi2)*cos(PHI);
g(3,1)=sin(phi1)*sin(PHI);
g(1,2)=sin(phi1)*cos(phi2)+cos(phi1)*sin(phi2)*cos(PHI);
g(2,2)=-sin(phi1)*sin(phi2)+cos(phi1)*cos(phi2)*cos(PHI);
g(3,2)=-cos(phi1)*sin(PHI);
g(1,3)=sin(phi2)*sin(PHI);
g(2,3)=cos(phi2)*sin(PHI);
g(3,3)=cos(PHI);

return
end

