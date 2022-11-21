function [GND_L2] = L2_GND(numel,alpha_vec,Burger,SF)

a=sqrt(3)/9;
c=sqrt(3)/84;
d=1/18;
e=3/14;



B = [ ...
a, 7*c, -13*c, -7*c, -a, 13*c, c, -c, 0;
-a, 13*c, -7*c, -c, 0, c, 7*c, -13*c a;
0, c, -c, -13*c, a, 7*c, 13*c, -7*c, -a;
a, -7*c, 13*c, 7*c, -a, 13*c, -c, -c, 0;
-a, -13*c, 7*c, c, 0,c, -7*c, -13*c, a;
0, -c, c, 13*c, a, 7*c, -13*c, -7*c, -a;
a,-7*c, -13*c, 7*c,-a, -13*c, c, c, 0;
-a, -13*c, -7*c, c, 0, -c, 7*c, 13*c, a;
0, -c, -c, 13*c, a, -7*c, 13*c, 7*c, -a;
a, 7*c, 13*c, -7*c, -a, -13*c, -c, c, 0;
-a, 13*c, 7*c, -c, 0, -c, -7*c, 13*c, a; % last term is different than Witzen et al. IJP 131 2020 102709
0, c, c, -13*c, a, -7*c, -13*c, 7*c, -a;
5*d, e, 0, e, 5*d, 0, 0, 0, -d;
5*d, 0, e, 0, -d, 0, e, 0, 5*d;
-d, 0, 0, 0, 5*d, e, 0, e, 5*d;
5*d, -e, 0, -e, 5*d, 0, 0, 0, -d;
5*d, 0, -e, 0, -d, 0, -e, 0, 5*d;
-d, 0, 0, 0, 5*d, -e, 0, -e, 5*d];



for iele=1:numel
    
    
    % Nye's tensor
    alphav(1:9,1)=alpha_vec(iele,:)';
    
    GND_L2.all(iele,1:18) = B * alphav/Burger*SF;
    
    GND_L2.norm(iele) = norm(GND_L2.all(iele,1:18));
    
    
end

return

end










